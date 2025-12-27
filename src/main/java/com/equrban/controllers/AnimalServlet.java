package com.equrban.controllers;
import com.equrban.dao.AnimalDAO;
import com.equrban.models.Animal;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/katalog")
public class AnimalServlet extends HttpServlet {
    private final AnimalDAO animalDAO = new AnimalDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
//        List<Animal> animals = animalDAO.getAllAnimals();
//        request.setAttribute("animals", animals);
//        request.getRequestDispatcher("katalog.jsp").forward(request, response);
        List<Animal> animals = animalDAO.getAllAnimals();
        request.setAttribute("animals", animals);
        request.getRequestDispatcher("/user/katalog.jsp").forward(request, response);

    }
}