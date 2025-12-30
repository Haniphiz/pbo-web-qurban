package com.equrban.dao;

import com.equrban.config.Database;
import com.equrban.models.User;

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

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                User user = new User();
                user.setUser_id(rs.getInt("user_id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phone"));
                user.setRole(rs.getString("role"));
                return user;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
 // Ambil alamat default user
   public User getDefaultAddress(int userId) {
  String sql =
    "SELECT address, province, city, district, postal_code " +
    "FROM user_address " +
    "WHERE user_id = ? AND is_default = TRUE " +
    "LIMIT 1";


    try (Connection conn = Database.getConnection();
         PreparedStatement stmt = conn.prepareStatement(sql)) {

        stmt.setInt(1, userId);
        ResultSet rs = stmt.executeQuery();

        if (rs.next()) {
            User u = new User();
            u.setAddress(rs.getString("address"));
            u.setProvince(rs.getString("province"));
            u.setCity(rs.getString("city"));
            u.setDistrict(rs.getString("district"));
            u.setPostalCode(rs.getString("postal_code"));
            return u;
        }

    } catch (Exception e) {
        e.printStackTrace();
    }
    return null;
}


    // Update atau insert alamat default
    public void updateAddress(
        int userId,
        String address,
        String province,
        String city,
        String district,
        String postalCode
) {

    String checkSql =
        "SELECT 1 FROM user_address WHERE user_id = ? AND is_default = TRUE";

    String insertSql =
        "INSERT INTO user_address " +
        "(user_id, address, province, city, district, postal_code, is_default) " +
        "VALUES (?, ?, ?, ?, ?, ?, TRUE)";

    String updateSql =
        "UPDATE user_address SET " +
        "address = ?, province = ?, city = ?, district = ?, postal_code = ? " +
        "WHERE user_id = ? AND is_default = TRUE";

    try (Connection conn = Database.getConnection();
         PreparedStatement check = conn.prepareStatement(checkSql)) {

        check.setInt(1, userId);
        ResultSet rs = check.executeQuery();

        if (rs.next()) {
            try (PreparedStatement ps = conn.prepareStatement(updateSql)) {
                ps.setString(1, address);
                ps.setString(2, province);
                ps.setString(3, city);
                ps.setString(4, district);
                ps.setString(5, postalCode);
                ps.setInt(6, userId);
                ps.executeUpdate();
            }
        } else {
            try (PreparedStatement ps = conn.prepareStatement(insertSql)) {
                ps.setInt(1, userId);
                ps.setString(2, address);
                ps.setString(3, province);
                ps.setString(4, city);
                ps.setString(5, district);
                ps.setString(6, postalCode);
                ps.executeUpdate();
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
