package com.equrban.controllers;

import com.equrban.dao.OrderDAO;
import com.equrban.dao.PaymentDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.*;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;

@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,
    maxFileSize = 10 * 1024 * 1024,     // 10 MB
    maxRequestSize = 20 * 1024 * 1024
)
public class PaymentServlet extends HttpServlet {

    private final PaymentDAO paymentDAO = new PaymentDAO();
    private final OrderDAO orderDAO = new OrderDAO();

    // ✅ SAMA POLA DENGAN ADD ANIMAL
    private static final String UPLOAD_DIR =
        "C:/Users/Lenovo/OneDrive/Documents/foto_hewan_qurban/verification";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("=== PAYMENT SERVLET DIPANGGIL ===");

        // ===== DATA =====
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        String paymentMethod = request.getParameter("payment_method");
        double amount = Double.parseDouble(request.getParameter("amount"));

        // ===== FILE =====
        Part proof = request.getPart("proof_image");
        if (proof == null || proof.getSize() == 0) {
            response.sendRedirect(
                request.getContextPath() + "/user/payment.jsp?error=proof"
            );
            return;
        }

        // Nama file aman
        String originalName = Paths
                .get(proof.getSubmittedFileName())
                .getFileName()
                .toString();

        String fileName = System.currentTimeMillis() + "_" + originalName;

        // Pastikan folder ada
        File dir = new File(UPLOAD_DIR);
        if (!dir.exists()) {
            dir.mkdirs();
        }

        // Simpan file
        proof.write(UPLOAD_DIR + File.separator + fileName);

        // ===== DATABASE =====
        paymentDAO.createPayment(orderId, paymentMethod, amount, fileName);
        orderDAO.updateOrderStatus(orderId, "pending");

        // ===== REDIRECT =====
        response.sendRedirect(
            request.getContextPath() + "/user/riwayat.jsp"
        );
    }
}
