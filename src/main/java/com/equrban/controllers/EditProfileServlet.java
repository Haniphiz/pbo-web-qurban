package com.equrban.controllers;

import com.equrban.models.User;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

public class EditProfileServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        request.setAttribute("userProfile", user);

        
        request.getRequestDispatcher("/user/editprofile.jsp")
       .forward(request, response);

    }
}
