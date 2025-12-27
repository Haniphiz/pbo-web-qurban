package com.equrban.controllers;

import com.equrban.dao.PaymentDAO;
import com.equrban.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/admin/payments")
public class AdminPaymentVerificationPageServlet extends HttpServlet {

    private final PaymentDAO paymentDAO = new PaymentDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null ||
            !"admin".equals(((User) session.getAttribute("user")).getRole())) {

            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        request.setAttribute(
            "payments",
            paymentDAO.getWaitingPayments()
        );

        request.getRequestDispatcher(
            "/admin/payment_verification.jsp"
        ).forward(request, response);
    }
}
