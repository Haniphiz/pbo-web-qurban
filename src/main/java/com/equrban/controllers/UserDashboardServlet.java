package com.equrban.controllers;

import com.equrban.dao.DeliveryDAO;
import com.equrban.dao.UserDAO;
import com.equrban.models.User;
import com.equrban.models.Delivery;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

public class UserDashboardServlet extends HttpServlet {

    private final DeliveryDAO deliveryDAO = new DeliveryDAO();
    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // User login
        User user = (User) session.getAttribute("user");

        // List delivery
        List<Delivery> deliveries =
                deliveryDAO.getDeliveriesByUser(user.getUser_id());

        // ✅ Ambil alamat default (RETURN User)
        User addressData = userDAO.getDefaultAddress(user.getUser_id());

        // ✅ Copy field alamat ke user session
        if (addressData != null) {
            user.setAddress(addressData.getAddress());
            user.setProvince(addressData.getProvince());
            user.setCity(addressData.getCity());
            user.setDistrict(addressData.getDistrict());
            user.setPostalCode(addressData.getPostalCode());
        }

        session.setAttribute("user", user);

        request.setAttribute("userProfile", user);
        request.setAttribute("deliveries", deliveries);

        request.getRequestDispatcher("/user/dashboard.jsp")
               .forward(request, response);
    }
}
