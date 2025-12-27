package com.equrban.controllers;

import com.equrban.dao.PaymentDAO;
import com.equrban.dao.OrderDAO;
import com.equrban.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {

    private final PaymentDAO paymentDAO = new PaymentDAO();
    private final OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");

        if (user == null || !"admin".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        int waitingPayments = paymentDAO.countWaitingPayments();
        int totalOrders = orderDAO.countAllOrders();

        request.setAttribute("waitingPayments", waitingPayments);
        request.setAttribute("totalOrders", totalOrders);

        request.getRequestDispatcher("/admin/dashboard.jsp")
               .forward(request, response);
    }
}
