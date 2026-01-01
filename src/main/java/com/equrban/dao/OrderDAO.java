package com.equrban.dao;

import com.equrban.config.Database;
import com.equrban.models.Order;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {

    // =========================
    // INSERT ORDER
    // =========================
    public int createOrder(int userId, double totalAmount) {

        String sql =
            "INSERT INTO orders (user_id, order_date, total_amount, status) " +
            "VALUES (?, NOW(), ?, 'pending')";

        try (Connection conn = Database.getConnection();
             PreparedStatement stmt =
                     conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setInt(1, userId);
            stmt.setDouble(2, totalAmount);
            stmt.executeUpdate();

            ResultSet rs = stmt.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    // =========================
    // GET ORDER BY ID (UNTUK CONFIRM)
    // =========================
    public Order getOrderById(int orderId) {

        String sql =
            "SELECT order_id, user_id, order_date, total_amount, status, is_confirmed " +
            "FROM orders WHERE order_id = ?";

        try (Connection conn = Database.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, orderId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                Order order = new Order();
                order.setOrderId(rs.getInt("order_id"));
                order.setUserId(rs.getInt("user_id"));
                order.setOrderDate(rs.getTimestamp("order_date"));
                order.setTotalAmount(rs.getDouble("total_amount"));
                order.setStatus(rs.getString("status"));
                order.setConfirmed(rs.getBoolean("is_confirmed"));
                return order;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    // =========================
    // RIWAYAT ORDER USER
    // =========================
    public List<Order> getOrdersByUser(int userId) {

        List<Order> orders = new ArrayList<>();

        String sql =
            "SELECT " +
            " o.order_id, " +
            " o.order_date, " +
            " o.total_amount, " +
            " o.status, " +
            " o.is_confirmed, " +
            " oi.animal_id, " +
            " a.name AS animal_name, " +
            " EXISTS ( " +
            "   SELECT 1 FROM reviews r " +
            "   WHERE r.user_id = o.user_id " +
            "   AND r.animal_id = oi.animal_id " +
            " ) AS has_review " +
            "FROM orders o " +
            "JOIN order_items oi ON o.order_id = oi.order_id " +
            "JOIN animals a ON oi.animal_id = a.animal_id " +
            "WHERE o.user_id = ? " +
            "ORDER BY o.order_date DESC";

        try (Connection conn = Database.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Order order = new Order();
                order.setOrderId(rs.getInt("order_id"));
                order.setOrderDate(rs.getTimestamp("order_date"));
                order.setTotalAmount(rs.getDouble("total_amount"));
                order.setStatus(rs.getString("status"));
                order.setAnimalId(rs.getInt("animal_id"));
                order.setAnimalName(rs.getString("animal_name"));
                order.setConfirmed(rs.getBoolean("is_confirmed"));
                order.setHasReview(rs.getBoolean("has_review"));

                orders.add(order);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return orders;
    }

    // =========================
    // UPDATE STATUS ORDER (ADMIN)
    // =========================
    public void updateOrderStatus(int orderId, String status) {

        String sql = "UPDATE orders SET status = ? WHERE order_id = ?";

        try (Connection conn = Database.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, status);
            stmt.setInt(2, orderId);
            stmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // =========================
    // KONFIRMASI PESANAN USER
    // =========================
    public void confirmOrder(int orderId) {

        String sql = "UPDATE orders SET is_confirmed = TRUE WHERE order_id = ?";

        try (Connection conn = Database.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, orderId);
            stmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // =========================
    // COUNT ALL ORDERS (ADMIN)
    // =========================
    public int countAllOrders() {

        String sql = "SELECT COUNT(*) FROM orders";

        try (Connection conn = Database.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            if (rs.next()) return rs.getInt(1);

        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    public int getAnimalIdByOrderId(int orderId) {
    String sql = "SELECT animal_id FROM order_items WHERE order_id = ?";
    try (Connection conn = Database.getConnection();
         PreparedStatement stmt = conn.prepareStatement(sql)) {

        stmt.setInt(1, orderId);
        ResultSet rs = stmt.executeQuery();
        if (rs.next()) {
            return rs.getInt("animal_id");
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return 0;
}

}
