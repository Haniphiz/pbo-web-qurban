package com.equrban.controllers;

import com.equrban.dao.UserDAO;
import com.equrban.models.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.io.IOException;

public class LoginServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String email = req.getParameter("email");
        String password = req.getParameter("password");

        System.out.println("Login attempt: " + email); // Debug

        User user = userDAO.loginUser(email, password);
    if (user != null && user.getRole() != null) {  // tambah pengecekan role juga
        // Ambil alamat default jika ada
        User addressUser = userDAO.getDefaultAddress(user.getUser_id());
        if (addressUser != null) {
            user.setAddress(addressUser.getAddress());
            user.setProvince(addressUser.getProvince());
            user.setCity(addressUser.getCity());
            user.setDistrict(addressUser.getDistrict());
            user.setPostalCode(addressUser.getPostalCode());
        }

        String role = user.getRole();
        HttpSession session = req.getSession(true);
        session.setAttribute("user", user);
        session.setAttribute("role", role);

        if ("admin".equalsIgnoreCase(role)) {  // pakai equalsIgnoreCase lebih aman
            resp.sendRedirect(req.getContextPath() + "/admin/dashboard");
        } else {
            resp.sendRedirect(req.getContextPath() + "/user/dashboard");
        }
    } else {
        System.out.println("Login failed for email: " + email + " - User not found or invalid credentials");
        resp.sendRedirect(req.getContextPath() + "/login.jsp?error=1");
    }
}
    // Jika ingin support GET, redirect ke login page
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        resp.sendRedirect(req.getContextPath() + "/login.jsp");
    }
}
