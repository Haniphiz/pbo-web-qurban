package com.equrban.dao;

import com.equrban.config.Database;
import com.equrban.models.Delivery;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DeliveryDAO {

    public List<Delivery> getDeliveriesByUser(int userId) {
        List<Delivery> list = new ArrayList<>();

        String sql =
            "SELECT d.delivery_id, d.delivery_date, d.address, " +
            "d.driver_name, d.status, o.order_id " +
            "FROM delivery_schedule d " +
            "JOIN orders o ON d.order_id = o.order_id " +
            "WHERE o.user_id = ? " +
            "ORDER BY d.delivery_date DESC";

        try (Connection conn = Database.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Delivery d = new Delivery();
                d.setDeliveryId(rs.getInt("delivery_id"));
                d.setOrderId(rs.getInt("order_id"));
                d.setDeliveryDate(rs.getDate("delivery_date"));
                d.setAddress(rs.getString("address"));
                d.setDriverName(rs.getString("driver_name"));
                d.setStatus(rs.getString("status"));

                list.add(d);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
public void createDelivery(int orderId, String address, Date deliveryDate) {

    String sql =
        "INSERT INTO delivery_schedule " +
        "(order_id, address, delivery_date, status) " +
        "VALUES (?, ?, ?, 'pending')";

    try (Connection conn = Database.getConnection();
         PreparedStatement stmt = conn.prepareStatement(sql)) {

        stmt.setInt(1, orderId);
        stmt.setString(2, address);
        stmt.setDate(3, deliveryDate);

        stmt.executeUpdate();

    } catch (Exception e) {
        e.printStackTrace();
    }
}

}
