package com.equrban.dao;

import com.equrban.config.Database;
import com.equrban.models.Payment;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class PaymentDAO {

  public void createPayment(int orderId,
                          String paymentMethod,
                          double amount,
                          String proofImage) {

    String sql = "INSERT INTO payments " +
                 "(order_id, payment_method, payment_date, amount, proof_image, status) " +
                 "VALUES (?, ?, NOW(), ?, ?, 'pending')";

    try (Connection conn = Database.getConnection();
         PreparedStatement stmt = conn.prepareStatement(sql)) {

        stmt.setInt(1, orderId);
        stmt.setString(2, paymentMethod);
        stmt.setDouble(3, amount);
        stmt.setString(4, proofImage);

        stmt.executeUpdate();

    } catch (Exception e) {
        e.printStackTrace();
    }
}

    
    public List<Payment> getWaitingPayments() {

    List<Payment> list = new ArrayList<>();

    String sql =
        "SELECT p.payment_id, p.order_id, p.payment_method, p.amount, " +
        "p.proof_image, p.status, o.user_id " +
        "FROM payments p " +
        "JOIN orders o ON p.order_id = o.order_id " +
        "WHERE p.status = 'pending'";

    try (Connection conn = Database.getConnection();
         PreparedStatement stmt = conn.prepareStatement(sql);
         ResultSet rs = stmt.executeQuery()) {

        while (rs.next()) {
            Payment p = new Payment();
            p.setPaymentId(rs.getInt("payment_id"));
            p.setOrderId(rs.getInt("order_id"));
            p.setPaymentMethod(rs.getString("payment_method"));
            p.setAmount(rs.getDouble("amount"));
            p.setProofImage(rs.getString("proof_image"));
            p.setStatus(rs.getString("status"));
            list.add(p);
        }

    } catch (Exception e) {
        e.printStackTrace();
    }

    return list;
}
        public void updatePaymentStatus(int paymentId, String status) {

    String sql = "UPDATE payments SET status = ? WHERE payment_id = ?";

    try (Connection conn = Database.getConnection();
         PreparedStatement stmt = conn.prepareStatement(sql)) {

        stmt.setString(1, status);
        stmt.setInt(2, paymentId);
        stmt.executeUpdate();

    } catch (Exception e) {
        e.printStackTrace();
    }
}

        public int countWaitingPayments() {

    String sql = "SELECT COUNT(*) FROM payments WHERE status = 'pending'";

    try (Connection conn = Database.getConnection();
         PreparedStatement stmt = conn.prepareStatement(sql);
         ResultSet rs = stmt.executeQuery()) {

        if (rs.next()) return rs.getInt(1);

    } catch (Exception e) {
        e.printStackTrace();
    }
    return 0;
}
        
        public void rejectOtherPayments(int orderId, int approvedPaymentId) {

    String sql =
        "UPDATE payments " +
        "SET status = 'rejected' " +
        "WHERE order_id = ? " +
        "AND payment_id != ? " +
        "AND status = 'pending'";

    try (Connection conn = Database.getConnection();
         PreparedStatement stmt = conn.prepareStatement(sql)) {

        stmt.setInt(1, orderId);
        stmt.setInt(2, approvedPaymentId);
        stmt.executeUpdate();

    } catch (Exception e) {
        e.printStackTrace();
    }
}


}
