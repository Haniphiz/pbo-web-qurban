package com.equrban.controllers;

import com.equrban.dao.AnimalDAO;
import com.equrban.models.Animal;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.UUID;

@WebServlet("/admin/animal/add")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,
    maxFileSize = 10 * 1024 * 1024,     // 10 MB
    maxRequestSize = 20 * 1024 * 1024
)
public class AdminAnimalServlet extends HttpServlet {

    private final AnimalDAO animalDAO = new AnimalDAO();

    // ✅ FOLDER EKSTERNAL (FINAL)
    private static final String UPLOAD_DIR =
            "C:/Users/Lenovo/OneDrive/Documents/foto_hewan_qurban/animals";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/admin/addanimal.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        // ===== DATA =====
        Animal animal = new Animal();
        animal.setName(req.getParameter("name"));
        animal.setCategory_id(parseIntSafe(req.getParameter("category_id")));
        animal.setAge(parseIntSafe(req.getParameter("age")));
        animal.setWeight(parseDoubleSafe(req.getParameter("weight")));
        animal.setPrice(parseDoubleSafe(req.getParameter("price")));
        animal.setStock(parseIntSafe(req.getParameter("stock")));
        animal.setDescription(req.getParameter("description"));

        // ===== FOTO =====
        Part photoPart = req.getPart("photo");
        if (photoPart == null || photoPart.getSize() == 0) {
            resp.sendRedirect(req.getContextPath() + "/admin/animal/add?error=photo");
            return;
        }

        // Nama file aman & unik
        String originalName = Paths
                .get(photoPart.getSubmittedFileName())
                .getFileName()
                .toString();

        String fileName = UUID.randomUUID() + "_" + originalName;

        // Pastikan folder upload ada
        File uploadDir = new File(UPLOAD_DIR);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        // Simpan file
        photoPart.write(UPLOAD_DIR + File.separator + fileName);

        // Simpan nama file ke DB
        animal.setPhoto(fileName);

        boolean success = animalDAO.insertAnimal(animal);

        if (success) {
            resp.sendRedirect(req.getContextPath() + "/admin/dashboard?success=animal_added");
        } else {
            resp.sendRedirect(req.getContextPath() + "/admin/animal/add?error=db");
        }
    }

    // ===== SAFE PARSE =====
    private int parseIntSafe(String val) {
        try {
            return Integer.parseInt(val);
        } catch (Exception e) {
            return 0;
        }
    }

    private double parseDoubleSafe(String val) {
        try {
            return Double.parseDouble(val);
        } catch (Exception e) {
            return 0.0;
        }
    }
}
