package com.bookstore.dao;

import com.bookstore.config.DbConfig;
import com.bookstore.model.Author;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AuthorDAO {

    public List<Author> getAllAuthors() throws SQLException, ClassNotFoundException {
        List<Author> authors = new ArrayList<>();
        String query = "SELECT * FROM Author";

        try (Connection connection = DbConfig.getDbConnection();
             PreparedStatement statement = connection.prepareStatement(query);
             ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {
                authors.add(extractAuthorFromResultSet(resultSet));
            }
        }
        return authors;
    }

    public Author getAuthorById(int authorId) throws SQLException, ClassNotFoundException {
        String query = "SELECT * FROM Author WHERE Author_id = ?";
        try (Connection connection = DbConfig.getDbConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {

            statement.setInt(1, authorId);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    return extractAuthorFromResultSet(resultSet);
                }
            }
        }
        return null;
    }

    public boolean addAuthor(Author author) throws SQLException, ClassNotFoundException {
        String sql = "INSERT INTO Author (Author_name, Author_bio, Author_email) VALUES (?, ?, ?)";
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, author.getName());
            stmt.setString(2, author.getBio());
            stmt.setString(3, author.getEmail());
            return stmt.executeUpdate() > 0;
        }
    }

    public boolean updateAuthor(Author author) throws SQLException, ClassNotFoundException {
        String sql = "UPDATE Author SET Author_name = ?, Author_bio = ?, Author_email = ? WHERE Author_id = ?";
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, author.getName());
            stmt.setString(2, author.getBio());
            stmt.setString(3, author.getEmail());
            stmt.setInt(4, author.getAuthorId());
            return stmt.executeUpdate() > 0;
        }
    }

    public boolean deleteAuthor(int authorId) throws SQLException, ClassNotFoundException {
        String sql = "DELETE FROM Author WHERE Author_id = ?";
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, authorId);
            return stmt.executeUpdate() > 0;
        }
    }

    private Author extractAuthorFromResultSet(ResultSet rs) throws SQLException {
        return new Author(
            rs.getInt("Author_id"),
            rs.getString("Author_name"),
            rs.getString("Author_bio"),
            rs.getString("Author_email")
        );
    }
}
