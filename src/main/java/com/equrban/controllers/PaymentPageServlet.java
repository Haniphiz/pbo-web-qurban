package com.equrban.controllers;

import com.equrban.dao.OrderDAO;
import com.equrban.models.Order;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/payment-page")
public class PaymentPageServlet extends HttpServlet {

    private final OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String orderIdParam = request.getParameter("orderId");
        if (orderIdParam == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Order ID tidak ditemukan");
            return;
        }

        int orderId = Integer.parseInt(orderIdParam);

        Order order = orderDAO.getOrderById(orderId);
        if (order == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Order tidak ditemukan");
            return;
        }

        request.setAttribute("order", order);
        request.getRequestDispatcher("/user/payment.jsp")
               .forward(request, response);
    }
}
