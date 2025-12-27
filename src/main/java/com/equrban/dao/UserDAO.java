package com.equrban.dao;

import com.equrban.config.Database;
import com.equrban.model.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {

    //REGISTER AKUNN
    public boolean registerUser(User user) {
    String sql = "INSERT INTO users (name, email, password, phone, role, created_at) "
               + "VALUES (?, ?, ?, ?, ?, NOW())";

    try (Connection conn = Database.getConnection();
         PreparedStatement stmt = conn.prepareStatement(sql)) {

        stmt.setString(1, user.getName());
        stmt.setString(2, user.getEmail());
        stmt.setString(3, user.getPassword());
        stmt.setString(4, user.getPhone());
        stmt.setString(5, user.getRole());

        return stmt.executeUpdate() > 0;

    } catch (Exception e) {
        e.printStackTrace();
        throw new RuntimeException(e);
    }
}
    
 // LOGIN   
    public User loginUser(String email, String password) {
    String sql = "SELECT * FROM users WHERE email = ? AND password = ?";

    try (Connection conn = Database.getConnection();
         PreparedStatement stmt = conn.prepareStatement(sql)) {

        stmt.setString(1, email);
        stmt.setString(2, password);

        var rs = stmt.executeQuery();
        if (rs.next()) {
            User user = new User();
            user.setUser_id(rs.getInt("user_id"));
            user.setName(rs.getString("name"));
            user.setEmail(rs.getString("email"));
            user.setRole(rs.getString("role"));
            return user;
        }

    } catch (Exception e) {
        e.printStackTrace();
    }
    return null; // user tidak ditemukan
}
 // Ambil alamat default user
    public String getDefaultAddress(int userId) {
        String sql = "SELECT address FROM user_address WHERE user_id = ? AND is_default = TRUE LIMIT 1";
        try (Connection conn = Database.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getString("address");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // Update atau insert alamat default
    public void updateAddress(int userId, String address) {
        String checkSql = "SELECT * FROM user_address WHERE user_id = ? AND is_default = TRUE";
        String insertSql = "INSERT INTO user_address(user_id, address, is_default) VALUES (?, ?, TRUE)";
        String updateSql = "UPDATE user_address SET address = ? WHERE user_id = ? AND is_default = TRUE";

        try (Connection conn = Database.getConnection();
             PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {

            checkStmt.setInt(1, userId);
            ResultSet rs = checkStmt.executeQuery();

            if (rs.next()) {
                try (PreparedStatement updateStmt = conn.prepareStatement(updateSql)) {
                    updateStmt.setString(1, address);
                    updateStmt.setInt(2, userId);
                    updateStmt.executeUpdate();
                }
            } else {
                try (PreparedStatement insertStmt = conn.prepareStatement(insertSql)) {
                    insertStmt.setInt(1, userId);
                    insertStmt.setString(2, address);
                    insertStmt.executeUpdate();
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    public boolean updateProfile(User user) {
    String sql = "UPDATE users SET name = ?, phone = ? WHERE user_id = ?";

    try (Connection conn = Database.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {

        ps.setString(1, user.getName());
        ps.setString(2, user.getPhone());
        ps.setInt(3, user.getUser_id());

        return ps.executeUpdate() > 0;

    } catch (Exception e) {
        e.printStackTrace();
        return false;
    }
}


}
