package com.bookstore.dao;

import com.bookstore.model.Review;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ReviewDAO {
    private Connection connection;

    public ReviewDAO(Connection connection) {
        this.connection = connection;
    }

    public List<Review> getReviews(int bookId) throws SQLException {
        List<Review> reviews = new ArrayList<>();
        String query = "SELECT * FROM Reviews r JOIN Review_Book_User rbu ON r.Review_id = rbu.Review_id WHERE rbu.Book_id = ? AND r.Review_status = 'Approved' ORDER BY r.Review_createdat DESC";
        
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, bookId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                reviews.add(new Review(
                    rs.getInt("Review_id"),
                    rs.getInt("Rating"),
                    rs.getString("Review_text"),
                    rs.getTimestamp("Review_createdat"),
                    rs.getString("Review_status")
                ));
            }
        }
        return reviews;
    }

    public double getAverageRatingForBook(int bookId) throws SQLException {
        String sql = "SELECT AVG(r.Rating) as avg_rating " +
                     "FROM Reviews r " +
                     "JOIN Review_Book_User rbu ON r.Review_id = rbu.Review_id " +
                     "WHERE rbu.Book_id = ? AND r.Review_status = 'Approved'";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, bookId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getDouble("avg_rating");
            }
        }
        return 0;
    }

    public int addReview(Review review, int bookId, int userId) throws SQLException {
        String insertReviewSql = "INSERT INTO Reviews (Rating, Review_text, Review_createdat, Review_status) VALUES (?, ?, ?, ?)";
        String insertLinkSql = "INSERT INTO Review_Book_User (Review_id, Book_id, User_id) VALUES (?, ?, ?)";
        
        try (PreparedStatement reviewStmt = connection.prepareStatement(insertReviewSql, Statement.RETURN_GENERATED_KEYS)) {
            reviewStmt.setInt(1, review.getRating());
            reviewStmt.setString(2, review.getReviewText());
            reviewStmt.setTimestamp(3, review.getReviewCreatedAt());
            reviewStmt.setString(4, "Approved"); // default status

            int affectedRows = reviewStmt.executeUpdate();

            if (affectedRows == 0) {
                throw new SQLException("Creating review failed, no rows affected.");
            }

            // Retrieve the generated Review_id
            ResultSet generatedKeys = reviewStmt.getGeneratedKeys();
            int reviewId = -1;
            if (generatedKeys.next()) {
                reviewId = generatedKeys.getInt(1);
            }

            // Link the review to the book and user
            try (PreparedStatement linkStmt = connection.prepareStatement(insertLinkSql)) {
                linkStmt.setInt(1, reviewId);
                linkStmt.setInt(2, bookId);
                linkStmt.setInt(3, userId);
                linkStmt.executeUpdate();
            }

            return reviewId; // Return the newly created Review_id
        }
    }
}

