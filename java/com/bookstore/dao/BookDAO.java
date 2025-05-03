package com.bookstore.dao;

import com.bookstore.model.Book;
import com.bookstore.model.Author;
import com.bookstore.config.DbConfig;

import java.sql.*;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.HashMap;

public class BookDAO {

    public List<Book> getAllBooksWithAuthors() throws SQLException, ClassNotFoundException {
        Map<Integer, Book> bookMap = new HashMap<>();

        Connection connection = DbConfig.getDbConnection();
        String sql = "SELECT b.Book_id, b.Book_Title, b.Book_coverimageurl, b.Book_price, b.Book_description, b.Book_isbn, " +
                     "b.Publication_date, b.Book_stockquantity, a.Author_id, a.Author_name, a.Author_bio, a.Author_email " +
                     "FROM Books b " +
                     "LEFT JOIN Author_Book ab ON b.Book_id = ab.Book_id " +
                     "LEFT JOIN Author a ON ab.Author_id = a.Author_id";

        PreparedStatement ps = connection.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            int bookId = rs.getInt("Book_id");
            Book book = bookMap.get(bookId);

            if (book == null) {
                book = new Book(
                    bookId,
                    rs.getString("Book_Title"),
                    rs.getString("Book_coverimageurl"),
                    rs.getDouble("Book_price"),
                    rs.getString("Book_description"),
                    rs.getString("Book_isbn"),
                    rs.getDate("Publication_date"),
                    rs.getInt("Book_stockquantity")
                );
                book.setAuthors(new ArrayList<>());
                
                
                System.out.println("Fetched Book: " + book.getTitle() + ", Price: Rs." + book.getPrice());

                bookMap.put(bookId, book);
            }

            int authorId = rs.getInt("Author_id");
            if (authorId > 0) {
                Author author = new Author(
                    authorId,
                    rs.getString("Author_name"),
                    rs.getString("Author_bio"),
                    rs.getString("Author_email")
                );
                book.getAuthors().add(author);
            }
        }

        rs.close();
        ps.close();
        connection.close();

        return new ArrayList<>(bookMap.values());
    }

    public List<Book> getBestSellers() {
        try {
            List<Book> allBooks = getAllBooksWithAuthors();
            return allBooks.subList(0, Math.min(5, allBooks.size()));
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    public List<Book> getNewArrivals() {
        try {
            List<Book> allBooks = getAllBooksWithAuthors();
            allBooks.sort((b1, b2) -> b2.getPublicationDate().compareTo(b1.getPublicationDate()));
            return allBooks.subList(0, Math.min(5, allBooks.size()));
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }
    public Book getBookById(int bookId) throws SQLException, ClassNotFoundException {
        Book book = null;

        Connection connection = DbConfig.getDbConnection();
        String sql = "SELECT b.Book_id, b.Book_Title, b.Book_coverimageurl, b.Book_price, b.Book_description, b.Book_isbn, " +
                     "b.Publication_date, b.Book_stockquantity, a.Author_id, a.Author_name, a.Author_bio, a.Author_email " +
                     "FROM Books b " +
                     "LEFT JOIN Author_Book ab ON b.Book_id = ab.Book_id " +
                     "LEFT JOIN Author a ON ab.Author_id = a.Author_id " +
                     "WHERE b.Book_id = ?";

        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setInt(1, bookId);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            if (book == null) {
                book = new Book(
                    rs.getInt("Book_id"),
                    rs.getString("Book_Title"),
                    rs.getString("Book_coverimageurl"),
                    rs.getDouble("Book_price"),
                    rs.getString("Book_description"),
                    rs.getString("Book_isbn"),
                    rs.getDate("Publication_date"),
                    rs.getInt("Book_stockquantity")
                );
                book.setAuthors(new ArrayList<>());
            }

            int authorId = rs.getInt("Author_id");
            if (authorId > 0) {
                Author author = new Author(
                    authorId,
                    rs.getString("Author_name"),
                    rs.getString("Author_bio"),
                    rs.getString("Author_email")
                );
                book.getAuthors().add(author);
            }
        }

        rs.close();
        ps.close();
        connection.close();

        return book;
    }
    public boolean updateBookCoverImage(int bookId, byte[] coverImage, Connection connection) {
        String sql = "UPDATE Books SET Book_coverimage = ? WHERE book_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setBytes(1, coverImage); // Set the byte array (image data)
            ps.setInt(2, bookId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    




    
    


}