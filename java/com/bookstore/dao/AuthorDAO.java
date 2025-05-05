package com.bookstore.dao;

import com.bookstore.config.DbConfig;
import com.bookstore.model.Author;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AuthorDAO {

    // Use DbConfig to get database connection
    public List<Author> getAllAuthors() {
        List<Author> authors = new ArrayList<>();
        
        // Query to fetch authors from the Author table
        String query = "SELECT * FROM Author";
        
        try (Connection connection = DbConfig.getDbConnection();
             PreparedStatement statement = connection.prepareStatement(query);
             ResultSet resultSet = statement.executeQuery()) {
            
            // Iterate over the result set and create Author objects
            while (resultSet.next()) {
                int authorId = resultSet.getInt("Author_id");
                String name = resultSet.getString("Author_name");
                String bio = resultSet.getString("Author_bio");
                String email = resultSet.getString("Author_email");
                
                Author author = new Author(authorId, name, bio, email);
                authors.add(author);
            }
            
        } catch (SQLException e) {
            e.printStackTrace(); // Handle the error accordingly
        }
        
        return authors;  // Ensure it returns a List<Author>
    }
}
