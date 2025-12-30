package com.equrban.controllers;

import com.equrban.dao.ReviewDAO;
import com.equrban.models.Review;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet({"/", "/index"})
public class IndexServlet extends HttpServlet {

    private final ReviewDAO reviewDAO = new ReviewDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Review> reviews = reviewDAO.getLatestReviews();
        request.setAttribute("reviews", reviews);

        request.getRequestDispatcher("/index.jsp")
               .forward(request, response);
    }
}
