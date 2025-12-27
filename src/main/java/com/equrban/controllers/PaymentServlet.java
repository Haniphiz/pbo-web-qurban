package com.equrban.controllers;

import com.equrban.dao.OrderDAO;
import com.equrban.dao.PaymentDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.*;

import java.io.File;
import java.io.IOException;


@MultipartConfig
public class PaymentServlet extends HttpServlet {

    private final PaymentDAO paymentDAO = new PaymentDAO();
    private final OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("=== PAYMENT SERVLET DIPANGGIL ===");

        int orderId = Integer.parseInt(request.getParameter("orderId"));
        String paymentMethod = request.getParameter("payment_method");
        double amount = Double.parseDouble(request.getParameter("amount"));

        Part proof = request.getPart("proof_image");
        String fileName = proof.getSubmittedFileName();

        String uploadPath = getServletContext().getRealPath("/uploads");
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdir();

        proof.write(uploadPath + File.separator + fileName);

        paymentDAO.createPayment(orderId, paymentMethod, amount, fileName);
        orderDAO.updateOrderStatus(orderId, "pending");

        response.sendRedirect(request.getContextPath() + "/user/riwayat.jsp");
    }
}

