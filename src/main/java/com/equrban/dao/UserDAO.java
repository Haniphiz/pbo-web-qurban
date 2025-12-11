package com.equrban.dao;

import com.equrban.config.Database;
import com.equrban.model.User;

import java.sql.Connection;
import java.sql.PreparedStatement;

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

}
