package com.equrban.controllers;

import com.equrban.dao.UserDAO;
import com.equrban.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

public class UpdateProfileServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        // Ambil session
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        User sessionUser = (User) session.getAttribute("user");

        // Ambil data dari form
        String name = request.getParameter("name");
        String phone = request.getParameter("phone");

        // Validasi
        if (name == null || name.trim().isEmpty()) {
            String msg = URLEncoder.encode("Nama wajib diisi", StandardCharsets.UTF_8);
            response.sendRedirect(request.getContextPath() + "/user/edit-profile?error=" + msg);
            return;
        }

        // Update object user (ID AMAN dari session)
        sessionUser.setName(name.trim());
        sessionUser.setPhone(phone != null && !phone.trim().isEmpty() ? phone.trim() : null);

        // Update ke database
        UserDAO userDAO = new UserDAO();
        boolean success = userDAO.updateProfile(sessionUser);

        if (success) {
            // Perbarui session
            session.setAttribute("user", sessionUser);

            response.sendRedirect(
                request.getContextPath() +
                "/user/dashboard?success=" +
                URLEncoder.encode("Profil berhasil diperbarui", StandardCharsets.UTF_8)
            );
        } else {
            String msg = URLEncoder.encode("Gagal memperbarui profil", StandardCharsets.UTF_8);
            response.sendRedirect(request.getContextPath() + "/user/edit-profile?error=" + msg);
        }
    }
}
