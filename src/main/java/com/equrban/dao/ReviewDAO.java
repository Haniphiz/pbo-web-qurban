package com.equrban.dao;

import com.equrban.config.Database;
import com.equrban.models.Review;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class ReviewDAO {

    public boolean insertReview(int userId, int animalId, int rating, String comment) {

        String sql =
            "INSERT INTO reviews (user_id, animal_id, rating, comment, created_at) " +
            "VALUES (?, ?, ?, ?, NOW())";

        try (Connection conn = Database.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            stmt.setInt(2, animalId);
            stmt.setInt(3, rating);
            stmt.setString(4, comment);

            stmt.executeUpdate();
            return true;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
   
public List<Review> getLatestReviews() {

    List<Review> reviews = new ArrayList<>();

    String sql =
        "SELECT r.rating, r.comment, r.created_at, " +
        "       a.name AS animal_name, " +
        "       u.name AS user_name " +
        "FROM reviews r " +
        "JOIN animals a ON r.animal_id = a.animal_id " +
        "JOIN users u ON r.user_id = u.user_id " +
        "ORDER BY r.created_at DESC " +
        "LIMIT 6";

    try (Connection conn = Database.getConnection();
         PreparedStatement stmt = conn.prepareStatement(sql);
         ResultSet rs = stmt.executeQuery()) {

        while (rs.next()) {
            Review review = new Review();
            review.setRating(rs.getInt("rating"));
            review.setComment(rs.getString("comment"));
            review.setAnimalName(rs.getString("animal_name"));
            review.setUserName(rs.getString("user_name"));
            review.setCreatedAt(rs.getTimestamp("created_at"));

            reviews.add(review);
        }

    } catch (Exception e) {
        e.printStackTrace();
    }

    return reviews;
}

}
