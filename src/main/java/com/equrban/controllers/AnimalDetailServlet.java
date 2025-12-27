package com.equrban.controllers;

import com.equrban.dao.AnimalDAO;
import com.equrban.models.Animal;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/animalDetail")
public class AnimalDetailServlet extends HttpServlet {

    private final AnimalDAO animalDAO = new AnimalDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");

        if (idParam == null || idParam.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST,
                    "Parameter id tidak valid");
            return;
        }

        try {
            int id = Integer.parseInt(idParam);
            Animal animal = animalDAO.getAnimalById(id);

            if (animal == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND,
                        "Hewan tidak ditemukan");
                return;
            }

            request.setAttribute("animal", animal);
            request.getRequestDispatcher("/user/detail.jsp")
                   .forward(request, response);

        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST,
                    "Parameter id tidak valid");
        }
    }
}
