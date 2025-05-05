package com.bookstore.dao;

import com.bookstore.model.Book;
import com.bookstore.model.RelatedBook;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RelatedBookDAO {
    private Connection connection;

    public RelatedBookDAO(Connection connection) {
        this.connection = connection;
    }

    public List<Book> getRelatedBooksWithDetails(int bookId, int limit) throws SQLException {
        List<Book> relatedBooks = new ArrayList<>();
        String sql = "SELECT DISTINCT b.Book_id, b.Book_Title, b.Book_coverimageurl, b.Book_price " +
                     "FROM Books b " +
                     "JOIN ( " +
                     "   SELECT rb.Related_bookid AS related_id FROM RelatedBooks rb WHERE rb.Book_id = ? " +
                     "   UNION " +
                     "   SELECT ab2.Book_id AS related_id FROM Author_Book ab1 " +
                     "   JOIN Author_Book ab2 ON ab1.Author_id = ab2.Author_id AND ab1.Book_id != ab2.Book_id " +
                     "   WHERE ab1.Book_id = ? " +
                     "   UNION " +
                     "   SELECT bc2.Book_id AS related_id FROM Book_Category bc1 " +
                     "   JOIN Book_Category bc2 ON bc1.Category_id = bc2.Category_id AND bc1.Book_id != bc2.Book_id " +
                     "   WHERE bc1.Book_id = ? " +
                     ") rel ON b.Book_id = rel.related_id " +
                     "LIMIT ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, bookId);
            ps.setInt(2, bookId);
            ps.setInt(3, bookId);
            ps.setInt(4, limit);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                relatedBooks.add(new Book(
                    rs.getInt("Book_id"),
                    rs.getString("Book_Title"),
                    rs.getString("Book_coverimageurl"),
                    rs.getDouble("Book_price"),
                    null, null, null, 0
                ));
            }
        }
        return relatedBooks;
    }

}


