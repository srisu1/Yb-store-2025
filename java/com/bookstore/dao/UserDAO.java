package com.bookstore.dao;

import com.bookstore.config.DbConfig;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.bookstore.model.User;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {

    private static final String INSERT_USER_QUERY = "INSERT INTO Users (User_fullname, User_email, User_passwordhash, User_phonenumber, User_languagepreference, User_role, User_profilepictureurl, User_loyaltypoints) " +
            "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

    private static final String SELECT_USER_BY_EMAIL_QUERY = "SELECT * FROM Users WHERE User_email = ?";
    private static final String SELECT_ALL_USERS_QUERY = "SELECT * FROM Users";
    private static final String CHECK_EMAIL_EXISTS_QUERY = "SELECT * FROM Users WHERE User_email = ?";
    private static final String CHECK_PHONE_EXISTS_QUERY = "SELECT * FROM Users WHERE User_phonenumber = ?";

    private Connection getConnection() throws SQLException, ClassNotFoundException {
        return DbConfig.getDbConnection();
    }

    public boolean isEmailExists(String email) {
        return checkIfExists(CHECK_EMAIL_EXISTS_QUERY, email);
    }

    public boolean isPhoneNumberExists(String phoneNumber) {
        return checkIfExists(CHECK_PHONE_EXISTS_QUERY, phoneNumber);
    }

    private boolean checkIfExists(String query, String value) {
        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, value);
            return statement.executeQuery().next();
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean addUser(User user) {
        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(INSERT_USER_QUERY)) {
            statement.setString(1, user.getFullName());
            statement.setString(2, user.getEmail());
            statement.setString(3, user.getPasswordHash());
            statement.setString(4, user.getPhoneNumber());
            statement.setString(5, user.getLanguagePreference());
            statement.setString(6, user.getRole());
            statement.setString(7, user.getProfilePictureUrl());
            statement.setInt(8, user.getLoyaltyPoints());

            return statement.executeUpdate() > 0;
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("[DB ERROR] During user registration:");
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateUserProfilePicture(int userId, byte[] profilePicture, Connection connection) {
        String sql = "UPDATE Users SET User_profilepicture = ? WHERE User_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setBytes(1, profilePicture);
            ps.setInt(2, userId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    
    
    
   

    public User getUserByEmail(String email) {
        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(SELECT_USER_BY_EMAIL_QUERY)) {
            statement.setString(1, email);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
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
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(SELECT_ALL_USERS_QUERY);
             ResultSet rs = statement.executeQuery()) {
            while (rs.next()) {
                users.add(new User(
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
                ));
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return users;
    }

    public boolean updateUser(User user, Connection connection) throws SQLException {
        String sql = "UPDATE Users SET User_fullname=?, User_phonenumber=?, User_languagepreference=? WHERE User_id=?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, user.getFullName());
            ps.setString(2, user.getPhoneNumber());
            ps.setString(3, user.getLanguagePreference());
            ps.setInt(4, user.getUserId());
            return ps.executeUpdate() > 0;
        }
    }
    
    
    // Update the profile picture URL (stored under resources/uploads/).
    
    public boolean updateProfilePictureUrl(int userId, String pictureUrl, Connection connection) 
            throws SQLException {
        String sql = "UPDATE Users SET User_profilepictureurl = ? WHERE User_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, pictureUrl);
            ps.setInt(2, userId);
            return ps.executeUpdate() > 0;
        }
    }
    
    public String getProfilePictureUrlByUserId(int userId) throws SQLException {
        String sql = "SELECT profilePictureUrl FROM users WHERE userId = ?";
        
        try (Connection connection = DbConfig.getDbConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("profilePictureUrl");
                }
            }
        }
        
        return null; // Return null if no URL is found
    }
   



    public User getUserByEmail(String email, Connection connection) throws SQLException {
        try (PreparedStatement ps = connection.prepareStatement(SELECT_USER_BY_EMAIL_QUERY)) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
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
            return null;
        }
    }
    
   

}
