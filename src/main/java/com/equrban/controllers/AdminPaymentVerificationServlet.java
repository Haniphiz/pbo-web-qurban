package com.equrban.controllers;

import com.equrban.dao.OrderDAO;
import com.equrban.dao.PaymentDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
@WebServlet("/admin/payment/verify")
public class AdminPaymentVerificationServlet extends HttpServlet {

    private final PaymentDAO paymentDAO = new PaymentDAO();
    private final OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int paymentId = Integer.parseInt(request.getParameter("paymentId"));
        int orderId   = Integer.parseInt(request.getParameter("orderId"));
        String action = request.getParameter("action");

       if ("approve".equals(action)) {

        // 1. Approve payment yang dipilih
        paymentDAO.updatePaymentStatus(paymentId, "paid");

        // 2. Update order
        orderDAO.updateOrderStatus(orderId, "paid");

        // 3. Reject SEMUA payment lain untuk order tsb
        paymentDAO.rejectOtherPayments(orderId, paymentId);

        } else if ("reject".equals(action)) {
            paymentDAO.updatePaymentStatus(paymentId, "rejected");

            // opsional: order tetap pending atau cancelled
            orderDAO.updateOrderStatus(orderId, "rejected");
        }

        response.sendRedirect(
            request.getContextPath() + "/admin/payments"
        );
    }
}

