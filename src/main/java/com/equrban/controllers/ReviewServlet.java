package com.equrban.controllers;

import com.equrban.dao.ReviewDAO;
import com.equrban.models.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/review")
public class ReviewServlet extends HttpServlet {

    private final ReviewDAO reviewDAO = new ReviewDAO();

    // =========================
    // TAMPILKAN FORM REVIEW
    // =========================
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String animalIdParam = request.getParameter("animalId");
        if (animalIdParam == null) {
            response.sendRedirect(request.getContextPath() + "/riwayat");
            return;
        }

        int animalId;
        try {
            animalId = Integer.parseInt(animalIdParam);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/riwayat");
            return;
        }

        request.setAttribute("animalId", animalId);
        request.getRequestDispatcher("/user/review.jsp").forward(request, response);
    }

    // =========================
    // SIMPAN REVIEW
    // =========================
            @Override
         protected void doPost(HttpServletRequest request, HttpServletResponse response)
                 throws ServletException, IOException {

             HttpSession session = request.getSession(false);
             if (session == null || session.getAttribute("user") == null) {
                 response.sendRedirect(request.getContextPath() + "/login.jsp");
                 return;
             }

             User user = (User) session.getAttribute("user");
             int userId = user.getUser_id(); // ✅ INI YANG KURANG

             int animalId = Integer.parseInt(request.getParameter("animalId"));
             int rating   = Integer.parseInt(request.getParameter("rating"));
             String comment = request.getParameter("comment");

             reviewDAO.insertReview(
                 userId,
                 animalId,
                 rating,
                 comment
             );

             response.sendRedirect(request.getContextPath() + "/riwayat");
         }
}