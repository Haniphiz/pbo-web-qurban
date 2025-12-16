package com.equrban.controllers;

import com.equrban.dao.UserDAO;
import com.equrban.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String email = req.getParameter("email");
        String password = req.getParameter("password");

        UserDAO dao = new UserDAO();
        User user = dao.loginUser(email, password);

        if (user != null) {
            // ✅ BUAT SESSION
            HttpSession session = req.getSession(true);
            session.setAttribute("user", user);
            session.setAttribute("role", user.getRole());

            resp.sendRedirect("index.jsp");
        } else {
            resp.sendRedirect("login.jsp?error=1");
        }
    }
}
