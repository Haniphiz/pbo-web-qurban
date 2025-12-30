package com.equrban.controllers;

import com.equrban.dao.UserDAO;
import com.equrban.models.User;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String phone = req.getParameter("phone");

        User user = new User(name, email, password, phone, "customer");
        UserDAO dao = new UserDAO();

        boolean success = dao.registerUser(user);

        if (success) {
            resp.sendRedirect("login.jsp?success=1");
        } else {
            resp.sendRedirect("register.jsp?error=1");
        }
    }
}
