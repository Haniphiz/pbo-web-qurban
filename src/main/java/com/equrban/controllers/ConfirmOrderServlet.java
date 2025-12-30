package com.equrban.controllers;

import com.equrban.dao.OrderDAO;
import com.equrban.models.Order;
import com.equrban.models.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/confirm-order")
public class ConfirmOrderServlet extends HttpServlet {

    private final OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // =========================
        // CEK LOGIN
        // =========================
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");

        // =========================
        // VALIDASI PARAMETER
        // =========================
        String orderIdParam = request.getParameter("orderId");
        if (orderIdParam == null) {
            response.sendRedirect(request.getContextPath() + "/riwayat");
            return;
        }

        int orderId;
        try {
            orderId = Integer.parseInt(orderIdParam);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/riwayat");
            return;
        }

        // =========================
        // AMBIL ORDER
        // =========================
        Order order = orderDAO.getOrderById(orderId);
        if (order == null) {
            response.sendRedirect(request.getContextPath() + "/riwayat");
            return;
        }

        // =========================
        // VALIDASI KEPEMILIKAN
        // =========================
        if (order.getUserId() != user.getUser_id()) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        // =========================
        // VALIDASI STATUS
        // =========================
        if (!"paid".equals(order.getStatus())) {
            response.sendRedirect(request.getContextPath() + "/riwayat");
            return;
        }

        // =========================
        // CEK SUDAH DIKONFIRMASI
        // =========================
        if (order.isConfirmed()) {
            response.sendRedirect(request.getContextPath() + "/riwayat");
            return;
        }

        // =========================
        // KONFIRMASI PESANAN (DB)
        // =========================
        orderDAO.confirmOrder(orderId);

        // =========================
        // REDIRECT KE RIWAYAT
        // =========================
        response.sendRedirect(request.getContextPath() + "/riwayat");
    }
}
