package com.equrban.controllers;

import com.equrban.dao.UserDAO;
import com.equrban.model.User;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
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
            HttpSession session = req.getSession();
            session.setAttribute("user", user);

            resp.sendRedirect("index.jsp");
        } else {
            resp.sendRedirect("login.jsp?error=1");
        }
    }
}
