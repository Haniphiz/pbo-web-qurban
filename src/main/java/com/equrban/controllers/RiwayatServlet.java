package com.equrban.controllers;

import com.equrban.dao.OrderDAO;
import com.equrban.model.User;
import com.equrban.models.Order;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/riwayat")
public class RiwayatServlet extends HttpServlet {

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

        // =========================
        // AMBIL USER
        // =========================
        User user = (User) session.getAttribute("user");
        int userId = user.getUser_id();

        // =========================
        // AMBIL RIWAYAT
        // =========================
        List<Order> orders = orderDAO.getOrdersByUser(userId);

        // PENTING: walaupun kosong, tetap dikirim
        request.setAttribute("orders", orders);

        // =========================
        // FORWARD KE JSP
        // =========================
        RequestDispatcher rd =
                request.getRequestDispatcher("/user/riwayat.jsp");
        rd.forward(request, response);
    }
}
