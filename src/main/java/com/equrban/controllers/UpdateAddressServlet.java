package com.equrban.controllers;

import com.equrban.dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

public class UpdateAddressServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String address = request.getParameter("address");
        int userId = ((com.equrban.model.User) session.getAttribute("user")).getUser_id();

        userDAO.updateAddress(userId, address);

        // Update session user
        com.equrban.model.User user = (com.equrban.model.User) session.getAttribute("user");
        user.setAddress(address);
        session.setAttribute("user", user);

        response.sendRedirect(request.getContextPath() + "/user/dashboard");
    }
}
