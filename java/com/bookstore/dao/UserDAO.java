package com.bookstore.dao;

import com.bookstore.config.DbConfig;
import com.bookstore.model.User;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {

	private static final String INSERT_USER_QUERY = "INSERT INTO Users (User_fullname, User_email, User_passwordhash, User_address, User_phonenumber, User_languagepreference, User_role, User_profilepictureurl, User_loyaltypoints) " +
		    "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
	
    private static final String SELECT_USER_BY_EMAIL_QUERY = "SELECT * FROM Users WHERE User_email = ?";
    private static final String SELECT_ALL_USERS_QUERY = "SELECT * FROM Users";
    
    private static final String CHECK_EMAIL_EXISTS_QUERY = "SELECT * FROM Users WHERE User_email = ?";
    private static final String CHECK_PHONE_EXISTS_QUERY = "SELECT * FROM Users WHERE User_phonenumber = ?";

    // Get connection using DbConfig
    private Connection getConnection() throws SQLException, ClassNotFoundException {
        return DbConfig.getDbConnection();
    }

    

    // Check if email exists
    public boolean isEmailExists(String email) {
        return checkIfExists(CHECK_EMAIL_EXISTS_QUERY, email);
    }

    // Check if phone number exists
    public boolean isPhoneNumberExists(String phoneNumber) {
        return checkIfExists(CHECK_PHONE_EXISTS_QUERY, phoneNumber);
    }

    private boolean checkIfExists(String query, String value) {
        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, value);
            ResultSet resultSet = statement.executeQuery();
            return resultSet.next();
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Add a new user to the database
    public boolean addUser(User user) {
        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(INSERT_USER_QUERY)) {
            statement.setString(1, user.getFullName());
            statement.setString(2, user.getEmail());
            statement.setString(3, user.getPasswordHash()); // Assuming password is already hashed
            statement.setString(4, user.getAddress());
            statement.setString(5, user.getPhoneNumber());
            statement.setString(6, user.getLanguagePreference());
            statement.setString(7, user.getRole());
            statement.setString(8, user.getProfilePictureUrl());
            statement.setInt(9, user.getLoyaltyPoints());

            int rowsAffected = statement.executeUpdate();
            System.out.println("[DB] Rows affected: " + rowsAffected); // Add this
            return rowsAffected > 0;
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("[DB ERROR] During user registration:");
            e.printStackTrace();
            return false;
        }
    }

    // Retrieve a user by email
    public User getUserByEmail(String email) {
        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(SELECT_USER_BY_EMAIL_QUERY)) {
            statement.setString(1, email);
            ResultSet resultSet = statement.executeQuery();
            if (resultSet.next()) {
            	return new User(
            		    resultSet.getInt("User_id"),          // NOT userId
            		    resultSet.getString("User_fullname"), // NOT fullName
            		    resultSet.getString("User_email"),
            		    resultSet.getString("User_passwordhash"),
            		    resultSet.getString("User_address"),
            		    resultSet.getString("User_phonenumber"), // NOT phoneNumber
            		    resultSet.getString("User_languagepreference"),
            		    resultSet.getString("User_role"),
            		    resultSet.getString("User_profilepictureurl"),
            		    resultSet.getInt("User_loyaltypoints"),
            		    resultSet.getString("User_createdat"),
            		    resultSet.getString("User_updatedat")
            		);
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Retrieve all users (for admin dashboard etc.)
    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(SELECT_ALL_USERS_QUERY);
             ResultSet resultSet = statement.executeQuery()) {
            while (resultSet.next()) {
            	users.add(new User(
            		    resultSet.getInt("User_id"),
            		    resultSet.getString("User_fullname"),
            		    resultSet.getString("User_email"),
            		    resultSet.getString("User_passwordhash"),
            		    resultSet.getString("User_address"),
            		    resultSet.getString("User_phonenumber"),
            		    resultSet.getString("User_languagepreference"),
            		    resultSet.getString("User_role"),
            		    resultSet.getString("User_profilepictureurl"),
            		    resultSet.getInt("User_loyaltypoints"),
            		    resultSet.getString("User_createdat"),
            		    resultSet.getString("User_updatedat")
            		));
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return users;
    }
}