package com.bookstore.dao;

import com.bookstore.model.Category;
import com.bookstore.config.DbConfig;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CategoryDAO {

    // Get all categories
    public List<Category> getAllCategories() throws SQLException, ClassNotFoundException {
        List<Category> categories = new ArrayList<>();
        String sql = "SELECT Category_id, Category_name FROM Category"; // Adjusted table name

        try (Connection connection = DbConfig.getDbConnection();
             PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                int categoryId = rs.getInt("Category_id");
                String categoryName = rs.getString("Category_name");

                Category category = new Category(categoryId, categoryName);
                categories.add(category);
            }
        }

       
        return categories;
    }

    // Get a category by ID
    public Category getCategoryById(int categoryId) throws SQLException, ClassNotFoundException {
        Category category = null;
        String sql = "SELECT Category_id, Category_name FROM Category WHERE Category_id = ?";  // Adjusted table name

        try (Connection connection = DbConfig.getDbConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setInt(1, categoryId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                category = new Category(
                    rs.getInt("Category_id"),
                    rs.getString("Category_name")
                );
            }
        }

        return category;
    }

    // Add a new category
    public boolean addCategory(Category category) throws SQLException, ClassNotFoundException {
    	String sql = "INSERT INTO Category (Category_name) VALUES (?)"; // Adjusted table name

        try (Connection connection = DbConfig.getDbConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setString(1, category.getCategoryName());
            return ps.executeUpdate() > 0;
        }
    }

    // Update a category
    public boolean updateCategory(Category category) throws SQLException, ClassNotFoundException {
    	String sql = "UPDATE Category SET Category_name = ? WHERE Category_id = ?"; // Adjusted table name

        try (Connection connection = DbConfig.getDbConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setString(1, category.getCategoryName());
            ps.setInt(2, category.getCategoryId());
            return ps.executeUpdate() > 0;
        }
    }

    // Delete a category
    public boolean deleteCategory(int categoryId) throws SQLException, ClassNotFoundException {
        String sql = "DELETE FROM Category WHERE Category_id = ?"; // Adjusted table name

        try (Connection connection = DbConfig.getDbConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setInt(1, categoryId);
            return ps.executeUpdate() > 0;
        }
    }
}