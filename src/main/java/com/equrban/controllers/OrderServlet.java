package com.equrban.controllers;

import com.equrban.dao.AnimalDAO;
import com.equrban.dao.DeliveryDAO;
import com.equrban.dao.OrderDAO;
import com.equrban.dao.OrderItemDAO;
import com.equrban.model.User;
import com.equrban.models.Animal;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/order")
public class OrderServlet extends HttpServlet {

    private final OrderDAO orderDAO = new OrderDAO();
    private final AnimalDAO animalDAO = new AnimalDAO();
    private final DeliveryDAO deliveryDAO = new DeliveryDAO();
    private final OrderItemDAO orderItemDAO = new OrderItemDAO();

    // =========================
    // GET → FORM ORDER
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
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Animal ID tidak ditemukan");
            return;
        }

        int animalId;
        try {
            animalId = Integer.parseInt(animalIdParam);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Animal ID tidak valid");
            return;
        }

        Animal animal = animalDAO.getAnimalById(animalId);
        if (animal == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Hewan tidak ditemukan");
            return;
        }

        request.setAttribute("animal", animal);
        request.getRequestDispatcher("/user/order.jsp")
               .forward(request, response);
    }

    // =========================
    // POST → SIMPAN ORDER
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
        int userId = user.getUser_id();

        int animalId;
        try {
            animalId = Integer.parseInt(request.getParameter("animalId"));
        } catch (NumberFormatException e) {
            throw new ServletException("Animal ID tidak valid");
        }

        String address = request.getParameter("address");
        java.sql.Date deliveryDate =
        java.sql.Date.valueOf(request.getParameter("delivery_date"));


        if (address == null || deliveryDate == null) {
            throw new ServletException("Data pengiriman tidak lengkap");
        }

        Animal animal = animalDAO.getAnimalById(animalId);
        if (animal == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Hewan tidak ditemukan");
            return;
        }

        // 1️⃣ INSERT ORDERS
        int orderId = orderDAO.createOrder(userId, animal.getPrice());
        if (orderId == 0) {
            throw new ServletException("Gagal membuat order");
        }

        // 2️⃣ INSERT ORDER_ITEMS
        orderItemDAO.createOrderItem(
                orderId,
                animalId,
                1,
                animal.getPrice()
        );

        // 3️⃣ INSERT DELIVERY
        deliveryDAO.createDelivery(orderId, address, deliveryDate);

        // 4️⃣ REDIRECT KE RIWAYAT
        response.sendRedirect(request.getContextPath() +  "/payment-page?orderId=" + orderId);
    }
}
