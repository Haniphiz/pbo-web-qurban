package com.equrban.dao;

import com.equrban.config.Database;
import java.sql.Connection;
import java.sql.PreparedStatement;

public class OrderItemDAO {

    // =========================
    // INSERT ORDER ITEM
    // =========================
    public void createOrderItem(int orderId, int animalId, int quantity, double price) {

        String sql = "INSERT INTO order_items (order_id, animal_id, quantity, price)" 
                + " VALUES (?, ?, ?, ?)";

        try (Connection conn = Database.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, orderId);
            stmt.setInt(2, animalId);
            stmt.setInt(3, quantity);
            stmt.setDouble(4, price);

            stmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
