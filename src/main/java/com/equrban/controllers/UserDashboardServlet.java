package com.equrban.controllers;

import com.equrban.dao.DeliveryDAO;
import com.equrban.dao.UserDAO;
import com.equrban.model.User;
import com.equrban.models.Delivery;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

public class UserDashboardServlet extends HttpServlet {

    private final DeliveryDAO deliveryDAO = new DeliveryDAO();
    private final UserDAO userDAO = new UserDAO(); // ✅ tambahkan ini

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1️⃣ Ambil session, pastikan user login
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // 2️⃣ Ambil user dari session
        User user = (User) session.getAttribute("user");

        // 3️⃣ Ambil delivery list user dari DAO
        List<Delivery> deliveries = deliveryDAO.getDeliveriesByUser(user.getUser_id());

        // 4️⃣ Ambil alamat default dari user_address
        String address = userDAO.getDefaultAddress(user.getUser_id());
        user.setAddress(address); // simpan ke session user juga
        session.setAttribute("user", user);

        // 5️⃣ Set request attribute untuk JSP
        request.setAttribute("userProfile", user);       // profil user
        request.setAttribute("deliveries", deliveries);  // list pengiriman

        // 6️⃣ Forward ke JSP dashboard
        request.getRequestDispatcher("/user/dashboard.jsp").forward(request, response);
    }
}
