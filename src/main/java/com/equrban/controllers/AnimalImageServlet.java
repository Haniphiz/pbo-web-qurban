/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.equrban.controllers;

import java.io.IOException;
import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/images/animals/*")
public class AnimalImageServlet extends HttpServlet {

    private static final String IMAGE_DIR =
            "C:/Users/Lenovo/OneDrive/Documents/foto_hewan_qurban/animals";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        String fileName = req.getPathInfo(); // /sapi.jpg
        if (fileName == null) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        File file = new File(IMAGE_DIR, fileName);
        if (!file.exists()) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        String mime = getServletContext().getMimeType(file.getName());
        resp.setContentType(mime != null ? mime : "image/jpeg");

        try (FileInputStream in = new FileInputStream(file);
             OutputStream out = resp.getOutputStream()) {

            in.transferTo(out);
        }
    }
}
