package com.equrban.controllers;

import java.io.IOException;
import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/images/payments/*")
public class PaymentImageServlet extends HttpServlet {

    private static final String IMAGE_DIR =
        "C:/Users/Lenovo/OneDrive/Documents/foto_hewan_qurban/verification";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        String fileName = req.getPathInfo(); // /bukti.jpg
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
