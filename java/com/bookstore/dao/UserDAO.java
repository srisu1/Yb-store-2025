package com.bookstore.dao;

import com.bookstore.config.DbConfig;
import com.bookstore.model.User;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {
    // SQL Queries
    private static final String INSERT_USER_QUERY = "INSERT INTO Users (User_fullname, User_email, User_passwordhash, " +
            "User_phonenumber, User_languagepreference, User_role, User_profilepictureurl, User_loyaltypoints) " +
            "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
    
    private static final String SELECT_USER_BY_ID = "SELECT * FROM Users WHERE User_id = ?";
    private static final String SELECT_USER_BY_EMAIL = "SELECT * FROM Users WHERE User_email = ?";
    private static final String SELECT_ALL_USERS = "SELECT * FROM Users";
    private static final String UPDATE_USER_ROLE = "UPDATE Users SET User_role = ? WHERE User_id = ?";
    private static final String DELETE_USER = "DELETE FROM Users WHERE User_id = ?";
    private static final String CHECK_EMAIL_EXISTS = "SELECT 1 FROM Users WHERE User_email = ?";
    private static final String CHECK_PHONE_EXISTS = "SELECT 1 FROM Users WHERE User_phonenumber = ?";

    // CRUD Operations
    public boolean addUser(User user) {
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(INSERT_USER_QUERY)) {
            
            setUserParameters(stmt, user);
            return stmt.executeUpdate() > 0;
            
        } catch (SQLException e) {
            handleException("Error adding user", e);
            return false;
        }
    }

    public User getUserById(int userId) {
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(SELECT_USER_BY_ID)) {
            
            stmt.setInt(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next() ? extractUserFromResultSet(rs) : null;
            }
        } catch (SQLException e) {
            handleException("Error getting user by ID", e);
            return null;
        }
    }

    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(SELECT_ALL_USERS);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                users.add(extractUserFromResultSet(rs));
            }
        } catch (SQLException e) {
            handleException("Error getting all users", e);
        }
        return users;
    }

    public boolean updateUserRole(User user) {
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(UPDATE_USER_ROLE)) {
            
            stmt.setString(1, user.getRole());
            stmt.setInt(2, user.getUserId());
            return stmt.executeUpdate() > 0;
            
        } catch (SQLException e) {
            handleException("Error updating user role", e);
            return false;
        }
    }

    public boolean deleteUser(int userId) {
        System.out.println("[DEBUG] Attempting to delete user ID: " + userId);
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(DELETE_USER)) {
            
            stmt.setInt(1, userId);
            int rowsAffected = stmt.executeUpdate();
            System.out.println("[DEBUG] Rows affected: " + rowsAffected);
            
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.err.println("[SQL ERROR] SQL State: " + e.getSQLState());
            System.err.println("[SQL ERROR] Error Code: " + e.getErrorCode());
            e.printStackTrace();
            return false;
        }
    }

    // Helper methods
    private User extractUserFromResultSet(ResultSet rs) throws SQLException {
        return new User(
            rs.getInt("User_id"),
            rs.getString("User_fullname"),
            rs.getString("User_email"),
            rs.getString("User_passwordhash"),
            rs.getString("User_phonenumber"),
            rs.getString("User_languagepreference"),
            rs.getString("User_role"),
            rs.getString("User_profilepictureurl"),
            rs.getInt("User_loyaltypoints"),
            rs.getString("User_createdat"),
            rs.getString("User_updatedat")
        );
    }

    private void setUserParameters(PreparedStatement stmt, User user) throws SQLException {
        stmt.setString(1, user.getFullName());
        stmt.setString(2, user.getEmail());
        stmt.setString(3, user.getPasswordHash());
        stmt.setString(4, user.getPhoneNumber());
        stmt.setString(5, user.getLanguagePreference());
        stmt.setString(6, user.getRole());
        stmt.setString(7, user.getProfilePictureUrl());
        stmt.setInt(8, user.getLoyaltyPoints());
    }

    // Existing functionality with improved error handling
    public boolean isEmailExists(String email) {
        return checkIfExists(CHECK_EMAIL_EXISTS, email);
    }

    public boolean isPhoneNumberExists(String phoneNumber) {
        return checkIfExists(CHECK_PHONE_EXISTS, phoneNumber);
    }

    private boolean checkIfExists(String query, String value) {
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setString(1, value);
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) {
            handleException("Error checking existence", e);
            return false;
        }
    }

    public User getUserByEmail(String email) {
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(SELECT_USER_BY_EMAIL)) {
            
            stmt.setString(1, email);
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next() ? extractUserFromResultSet(rs) : null;
            }
        } catch (SQLException e) {
            handleException("Error getting user by email", e);
            return null;
        }
    }

    // Error handling
    private void handleException(String message, SQLException e) {
        System.err.println("[DB ERROR] " + message);
        e.printStackTrace();
    }

    // Keep existing methods with connection parameters if needed
    public boolean updateUserProfilePicture(int userId, byte[] profilePicture, Connection connection) throws SQLException {
        String sql = "UPDATE Users SET User_profilepicture = ? WHERE User_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setBytes(1, profilePicture);
            ps.setInt(2, userId);
            return ps.executeUpdate() > 0;
        }
    }

    public boolean updateProfilePictureUrl(int userId, String pictureUrl, Connection connection) throws SQLException {
        String sql = "UPDATE Users SET User_profilepictureurl = ? WHERE User_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, pictureUrl);
            ps.setInt(2, userId);
            return ps.executeUpdate() > 0;
        }
    }
}