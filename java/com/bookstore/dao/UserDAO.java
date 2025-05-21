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
    private static final String UPDATE_PROFILE_PIC_URL = "UPDATE Users SET User_profilepictureurl = ? WHERE User_id = ?";
    private static final String UPDATE_PROFILE = "UPDATE Users SET User_fullname = ?, User_phonenumber = ?, User_languagepreference = ? WHERE User_id = ?";

    // CRUD Operations (Default Connection)
    public boolean addUser(User user) {
        try (Connection conn = DbConfig.getDbConnection()) {
            return addUser(user, conn);
        } catch (SQLException e) {
            handleException("Error adding user", e);
            return false;
        }
    }

    public User getUserById(int userId) throws SQLException {
        try (Connection conn = DbConfig.getDbConnection()) {
            return getUserById(userId, conn);
        }
    }

    public User getUserByEmail(String email) throws SQLException {
        try (Connection conn = DbConfig.getDbConnection()) {
            return getUserByEmail(email, conn);
        }
    }

    public List<User> getAllUsers() throws SQLException {
        try (Connection conn = DbConfig.getDbConnection()) {
            return getAllUsers(conn);
        }
    }

    public boolean updateUserRole(User user) throws SQLException {
        try (Connection conn = DbConfig.getDbConnection()) {
            return updateUserRole(user, conn);
        }
    }

    public boolean deleteUser(int userId) throws SQLException {
        try (Connection conn = DbConfig.getDbConnection()) {
            return deleteUser(userId, conn);
        }
    }

    public boolean isEmailExists(String email) {
        try (Connection conn = DbConfig.getDbConnection()) {
            return isEmailExists(email, conn);
        } catch (SQLException e) {
            handleException("Error checking email existence", e);
            return false;
        }
    }

    public boolean isPhoneNumberExists(String phoneNumber) {
        try (Connection conn = DbConfig.getDbConnection()) {
            return isPhoneNumberExists(phoneNumber, conn);
        } catch (SQLException e) {
            handleException("Error checking phone existence", e);
            return false;
        }
    }

    // CRUD Operations (With Connection)
    public boolean addUser(User user, Connection conn) throws SQLException {
        try (PreparedStatement stmt = conn.prepareStatement(INSERT_USER_QUERY)) {
            setUserParameters(stmt, user);
            return stmt.executeUpdate() > 0;
        }
    }

    public User getUserById(int userId, Connection conn) throws SQLException {
        try (PreparedStatement stmt = conn.prepareStatement(SELECT_USER_BY_ID)) {
            stmt.setInt(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next() ? extractUserFromResultSet(rs) : null;
            }
        }
    }

    public User getUserByEmail(String email, Connection conn) throws SQLException {
        try (PreparedStatement stmt = conn.prepareStatement(SELECT_USER_BY_EMAIL)) {
            stmt.setString(1, email);
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next() ? extractUserFromResultSet(rs) : null;
            }
        }
    }

    public List<User> getAllUsers(Connection conn) throws SQLException {
        List<User> users = new ArrayList<>();
        try (PreparedStatement stmt = conn.prepareStatement(SELECT_ALL_USERS);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                users.add(extractUserFromResultSet(rs));
            }
        }
        return users;
    }

    public boolean updateUserRole(User user, Connection conn) throws SQLException {
        try (PreparedStatement stmt = conn.prepareStatement(UPDATE_USER_ROLE)) {
            stmt.setString(1, user.getRole());
            stmt.setInt(2, user.getUserId());
            return stmt.executeUpdate() > 0;
        }
    }

    public boolean deleteUser(int userId, Connection conn) throws SQLException {
        try (PreparedStatement stmt = conn.prepareStatement(DELETE_USER)) {
            stmt.setInt(1, userId);
            return stmt.executeUpdate() > 0;
        }
    }

    public boolean isEmailExists(String email, Connection conn) throws SQLException {
        return checkIfExists(CHECK_EMAIL_EXISTS, email, conn);
    }

    public boolean isPhoneNumberExists(String phoneNumber, Connection conn) throws SQLException {
        return checkIfExists(CHECK_PHONE_EXISTS, phoneNumber, conn);
    }

    public boolean updateUserProfilePicture(int userId, byte[] profilePicture, Connection conn) throws SQLException {
        String sql = "UPDATE Users SET User_profilepicture = ? WHERE User_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setBytes(1, profilePicture);
            ps.setInt(2, userId);
            return ps.executeUpdate() > 0;
        }
    }

    public boolean updateProfilePictureUrl(int userId, String pictureUrl, Connection conn) throws SQLException {
        try (PreparedStatement stmt = conn.prepareStatement(UPDATE_PROFILE_PIC_URL)) {
            stmt.setString(1, pictureUrl);
            stmt.setInt(2, userId);
            return stmt.executeUpdate() > 0;
        }
    }

    public boolean updateUser(User user, Connection conn) throws SQLException {
        try (PreparedStatement stmt = conn.prepareStatement(UPDATE_PROFILE)) {
            stmt.setString(1, user.getFullName());
            stmt.setString(2, user.getPhoneNumber());
            stmt.setString(3, user.getLanguagePreference());
            stmt.setInt(4, user.getUserId());
            return stmt.executeUpdate() > 0;
        }
    }

    // Helper Methods
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

    private boolean checkIfExists(String query, String value, Connection conn) throws SQLException {
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, value);
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next();
            }
        }
    }

    private void handleException(String message, SQLException e) {
        System.err.println("[DB ERROR] " + message);
        e.printStackTrace();
    }
}
