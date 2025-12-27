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

        String sql = "INSERT INTO orders (user_id, order_date, total_amount, status)"
        + "VALUES (?, NOW(), ?, 'pending')";

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
// GET ORDER BY ID (PAYMENT)
// =========================
public Order getOrderById(int orderId) {

    String sql =
        "SELECT " +
        "    o.order_id, " +
        "    o.order_date, " +
        "    o.total_amount, " +
        "    o.status " +
        "FROM orders o " +
        "WHERE o.order_id = ?";

    try (Connection conn = Database.getConnection();
         PreparedStatement stmt = conn.prepareStatement(sql)) {

        stmt.setInt(1, orderId);
        ResultSet rs = stmt.executeQuery();

        if (rs.next()) {
            Order order = new Order();
            order.setOrderId(rs.getInt("order_id"));
            order.setOrderDate(rs.getTimestamp("order_date"));
            order.setTotalAmount(rs.getDouble("total_amount"));
            order.setStatus(rs.getString("status"));

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
        "    o.order_id, " +
        "    o.order_date, " +
        "    o.total_amount, " +
        "    o.status, " +
        "    a.name AS animal_name " +
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
                order.setAnimalName(rs.getString("animal_name"));

                orders.add(order);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return orders;
    }

    // =========================
    // UPDATE STATUS ORDER
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
}
