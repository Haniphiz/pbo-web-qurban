package com.equrban.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.ServletOutputStream;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;


@WebServlet("/image")
public class TeamServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    // Folder tempat gambar disimpan (sesuaikan dengan lokasi file di server)


    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    String fileName = request.getParameter("name");
    if (fileName == null || fileName.isEmpty()) {
        response.sendError(HttpServletResponse.SC_BAD_REQUEST, "File name is missing");
        return;
    }

    // Lokasi folder gambar di runtime
    String imageDir = getServletContext().getRealPath("/assets/team/") + File.separator;
    File file = new File(imageDir + fileName);

    if (!file.exists() || file.isDirectory()) {
        response.sendError(HttpServletResponse.SC_NOT_FOUND, "File not found");
        return;
    }

    // Set content type
    String mimeType = getServletContext().getMimeType(file.getAbsolutePath());
    if (mimeType == null) {
        mimeType = "application/octet-stream";
    }
    response.setContentType(mimeType);
    response.setContentLengthLong(file.length());

    // Kirim file
    try (FileInputStream in = new FileInputStream(file);
         ServletOutputStream out = response.getOutputStream()) {
        byte[] buffer = new byte[4096];
        int bytesRead;
        while ((bytesRead = in.read(buffer)) != -1) {
            out.write(buffer, 0, bytesRead);
        }
    }
}

}
