package com.bookstore.dao;

import com.bookstore.model.Book;
import com.bookstore.model.Author;
import com.bookstore.config.DbConfig;
import com.bookstore.model.Category;


import java.sql.*;
import java.util.*;

public class BookDAO {
	public List<Book> getAllBooksWithAuthors() throws SQLException, ClassNotFoundException {
	    Map<Integer, Book> bookMap = new HashMap<>();

	    Connection connection = DbConfig.getDbConnection();
	    String sql = "SELECT b.Book_id, b.Book_Title, b.Book_coverimageurl, b.Book_price, " +
	             "b.Book_description, b.Book_isbn, b.Publication_date, b.Book_stockquantity, " +
	             "a.Author_id, a.Author_name, a.Author_bio, a.Author_email, " +
	             "c.Category_id, c.Category_name " +
	             "FROM Books b " +
	             "LEFT JOIN Author_Book ab ON b.Book_id = ab.Book_id " +
	             "LEFT JOIN Author a ON ab.Author_id = a.Author_id " +
	             "LEFT JOIN Book_Category bc ON b.Book_id = bc.Book_id " +
	             "LEFT JOIN Category c ON bc.Category_id = c.Category_id";

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
	            book.setCategories(new ArrayList<>());  // Initialize categories list here
	            bookMap.put(bookId, book);
	        }

	        // Adding Author
	        int authorId = rs.getInt("Author_id");
	        if (!rs.wasNull()) {
	            Author author = new Author(
	                authorId,
	                rs.getString("Author_name"),
	                rs.getString("Author_bio"),
	                rs.getString("Author_email")
	            );
	            if (!book.getAuthors().contains(author)) {
	                book.getAuthors().add(author);
	            }
	        }

	        // Adding Category
	        String categoryName = rs.getString("Category_name");
	        int categoryId = rs.getInt("Category_id");
	        if (categoryName != null && !categoryName.isEmpty()) {
	            Category category = new Category(categoryId, categoryName);
	            // Checking if the category is already added
	            boolean alreadyAdded = book.getCategories().stream()
	                .anyMatch(c -> c.getCategoryName().equalsIgnoreCase(categoryName));
	            if (!alreadyAdded) {
	                book.getCategories().add(category);
	            }
	        }
	    }

	    rs.close();
	    ps.close();
	    connection.close();

	    System.out.println("DEBUG: Found " + bookMap.size() + " books");
	    return new ArrayList<>(bookMap.values());
	}

	// Adding these methods home.jsp
	public List<Book> getBooksOfTheWeek() throws SQLException, ClassNotFoundException {
	    Connection connection = DbConfig.getDbConnection();
	    String query = "SELECT b.Book_id, b.Book_Title, b.Book_coverimageurl, " + // Explicitly include cover
	                   "b.Book_price, b.Book_description, b.Book_isbn, " +
	                   "b.Publication_date, b.Book_stockquantity " +
	                   "FROM Books b " +
	                   "ORDER BY b.weekly_views DESC, b.publication_date DESC " +
	                   "LIMIT 4";
	    
	    try (PreparedStatement ps = connection.prepareStatement(query)) {
	        ResultSet rs = ps.executeQuery();
	        List<Book> books = new ArrayList<>();
	        
	        while (rs.next()) {
	            Book book = mapResultSetToBook(rs);
	            book.setCategories(getCategoriesForBook(connection, book.getBookId()));
	            books.add(book);
	        }
	        return books;
	    }
	}

	// Updating existing getNewArrivals to use proper SQL
	public List<Book> getNewArrivals() throws SQLException, ClassNotFoundException {
	    Connection connection = DbConfig.getDbConnection();
	    String query = "SELECT * FROM Books " + // Table name with uppercase B
	                   "WHERE Publication_date IS NOT NULL " +
	                   "ORDER BY Publication_date DESC " + // Column name with uppercase
	                   "LIMIT 4";
	    
	    try (PreparedStatement ps = connection.prepareStatement(query)) {
	        ResultSet rs = ps.executeQuery();
	        List<Book> books = new ArrayList<>();

	        while (rs.next()) {
	            Book book = mapResultSetToBook(rs);
	            book.setCategories(getCategoriesForBook(connection, book.getBookId()));
	            books.add(book);
	        }

	        // Fallback: if no books with publication_date, get 4 random books
	        if (books.isEmpty()) {
	            String fallbackQuery = "SELECT * FROM books ORDER BY RAND() LIMIT 4";
	            try (PreparedStatement fallbackPs = connection.prepareStatement(fallbackQuery)) {
	                ResultSet fallbackRs = fallbackPs.executeQuery();
	                while (fallbackRs.next()) {
	                    Book fallbackBook = mapResultSetToBook(fallbackRs);
	                    fallbackBook.setCategories(getCategoriesForBook(connection, fallbackBook.getBookId()));
	                    books.add(fallbackBook);
	                }
	            }
	        }

	        return books;
	    }
	}


	// Updating getBestSellers logic to use proper SQL
	public List<Book> getBestSellers() throws SQLException, ClassNotFoundException {
	    Connection connection = DbConfig.getDbConnection();
	    String query = "SELECT b.*, SUM(oi.Quantity) AS total_sold " +
	                   "FROM Books b " + 
	                   "JOIN OrderItem oi ON b.Book_id = oi.Book_id " +
	                   "GROUP BY b.Book_id " +
	                   "ORDER BY total_sold DESC " +
	                   "LIMIT 4";
	    
	    try (PreparedStatement ps = connection.prepareStatement(query)) {
	        ResultSet rs = ps.executeQuery();
	        List<Book> books = new ArrayList<>();

	        while (rs.next()) {
	            Book book = mapResultSetToBook(rs);
	            book.setCategories(getCategoriesForBook(connection, book.getBookId()));
	            books.add(book);
	        }

	        // Fallback: if no best sellers, show 4 random books
	        if (books.isEmpty()) {
	            String fallbackQuery = "SELECT * FROM books ORDER BY RAND() LIMIT 4";
	            try (PreparedStatement fallbackPs = connection.prepareStatement(fallbackQuery)) {
	                ResultSet fallbackRs = fallbackPs.executeQuery();
	                while (fallbackRs.next()) {
	                    Book fallbackBook = mapResultSetToBook(fallbackRs);
	                    fallbackBook.setCategories(getCategoriesForBook(connection, fallbackBook.getBookId()));
	                    books.add(fallbackBook);
	                }
	            }
	        }

	        return books;
	    }
	}


    public Book getBookById(int bookId) throws SQLException, ClassNotFoundException {
        Book book = null;

        Connection connection = DbConfig.getDbConnection();
        String sql = "SELECT b.Book_id, b.Book_Title, b.Book_coverimageurl, b.Book_price, b.Book_description, " +
                     "b.Book_isbn, b.Publication_date, b.Book_stockquantity, " +
                     "a.Author_id, a.Author_name, a.Author_bio, a.Author_email, " +
                     "c.Category_id, c.Category_name " +  // Include Category_id in SELECT clause
                     "FROM Books b " +
                     "LEFT JOIN Author_Book ab ON b.Book_id = ab.Book_id " +
                     "LEFT JOIN Author a ON ab.Author_id = a.Author_id " +
                     "LEFT JOIN Book_Category bc ON b.Book_id = bc.Book_id " +
                     "LEFT JOIN Category c ON bc.Category_id = c.Category_id " +
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
                book.setCategories(new ArrayList<>());  // Initialize categories list here
            }

            // Add Author
            int authorId = rs.getInt("Author_id");
            if (authorId > 0) {
                Author author = new Author(
                    authorId,
                    rs.getString("Author_name"),
                    rs.getString("Author_bio"),
                    rs.getString("Author_email")
                );
                if (!book.getAuthors().contains(author)) {
                    book.getAuthors().add(author);
                }
            }

            // Add Category
            String categoryName = rs.getString("Category_name");
            int categoryId = rs.getInt("Category_id");
            if (categoryName != null && !categoryName.isEmpty()) {
                Category category = new Category(categoryId, categoryName);
                book.getCategories().add(category);
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
            ps.setBytes(1, coverImage);
            ps.setInt(2, bookId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    private Book mapResultSetToBook(ResultSet rs) throws SQLException {
        int bookId = rs.getInt("Book_id");
        String title = rs.getString("Book_Title");
        String coverUrl = rs.getString("Book_coverimageurl");
        double price = rs.getDouble("Book_price");
        String description = rs.getString("Book_description");
        String isbn = rs.getString("Book_isbn");
        java.sql.Date pubDate = rs.getDate("Publication_date");
        int stockQty = rs.getInt("Book_stockquantity");

        return new Book(bookId, title, coverUrl, price, description, isbn, pubDate, stockQty);
    }

    
    public List<Category> getCategoriesForBook(Connection connection, int bookId) throws SQLException {
        List<Category> categories = new ArrayList<>();

        String query = "SELECT c.Category_id, c.Category_name FROM Category c " +
                       "JOIN Book_Category bc ON c.Category_id = bc.Category_id " +
                       "WHERE bc.Book_id = ?";

        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, bookId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Category category = new Category(
                    rs.getInt("Category_id"),
                    rs.getString("Category_name")
                );
                categories.add(category);
            }
        }

        return categories;
    }
    
    

    public List<Book> getBooksByCategory(Connection connection, String categoryId) throws SQLException {
        List<Book> books = new ArrayList<>();
        String query = "SELECT b.* FROM Books b " +
                       "JOIN Book_Category bc ON b.Book_id = bc.Book_id " +
                       "WHERE bc.Category_id = ?";

        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, Integer.parseInt(categoryId));
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Book book = mapResultSetToBook(rs);
                book.setCategories(getCategoriesForBook(connection, book.getBookId()));
                books.add(book);
            }
        }
        return books;
    }
    
    
    //STUFF FOR ADMIN PANEL BEGINS HERE 

    
    public int addBook(Book book, List<Integer> authorIds, List<Integer> categoryIds) 
            throws SQLException, ClassNotFoundException {
        Connection connection = null;
        int generatedId = -1;
        try {
            connection = DbConfig.getDbConnection();
            connection.setAutoCommit(false);

            // Inserting book
            String sql = "INSERT INTO Books (Book_Title, Book_coverimageurl, Book_price, " +
                         "Book_description, Book_isbn, Publication_date, Book_stockquantity) " +
                         "VALUES (?, ?, ?, ?, ?, ?, ?)";
            
            try (PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
                ps.setString(1, book.getTitle());
                ps.setString(2, book.getCoverImageUrl());
                ps.setDouble(3, book.getPrice());
                ps.setString(4, book.getDescription());
                ps.setString(5, book.getIsbn());
                ps.setDate(6, new java.sql.Date(book.getPublicationDate().getTime()));
                ps.setInt(7, book.getStockQuantity());
                ps.executeUpdate();

                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) generatedId = rs.getInt(1);
                }
            }

            // Inserting authors
            if (authorIds != null && !authorIds.isEmpty()) {
                String authorSql = "INSERT INTO Author_Book (Book_id, Author_id) VALUES (?, ?)";
                try (PreparedStatement ps = connection.prepareStatement(authorSql)) {
                    for (int authorId : authorIds) {
                        ps.setInt(1, generatedId);
                        ps.setInt(2, authorId);
                        ps.addBatch();
                    }
                    ps.executeBatch();
                }
            }

            // Inserting categories
            if (categoryIds != null && !categoryIds.isEmpty()) {
                String categorySql = "INSERT INTO Book_Category (Book_id, Category_id) VALUES (?, ?)";
                try (PreparedStatement ps = connection.prepareStatement(categorySql)) {
                    for (int categoryId : categoryIds) {
                        ps.setInt(1, generatedId);
                        ps.setInt(2, categoryId);
                        ps.addBatch();
                    }
                    ps.executeBatch();
                }
            }

            connection.commit();
            return generatedId;
            
        } catch (SQLException e) {
            if (connection != null) connection.rollback();
            throw e;
        } finally {
            if (connection != null) connection.close();
        }
    }

    public void updateBook(Book book, List<Integer> authorIds, List<Integer> categoryIds) 
            throws SQLException, ClassNotFoundException {
        Connection connection = null;
        try {
            connection = DbConfig.getDbConnection();
            connection.setAutoCommit(false);

            // Updatin book
            String sql = "UPDATE Books SET Book_Title=?, Book_coverimageurl=?, Book_price=?, " +
                        "Book_description=?, Book_isbn=?, Publication_date=?, Book_stockquantity=? " +
                        "WHERE Book_id=?";
            
            try (PreparedStatement ps = connection.prepareStatement(sql)) {
                ps.setString(1, book.getTitle());
                ps.setString(2, book.getCoverImageUrl());
                ps.setDouble(3, book.getPrice());
                ps.setString(4, book.getDescription());
                ps.setString(5, book.getIsbn());
                ps.setDate(6, new java.sql.Date(book.getPublicationDate().getTime()));
                ps.setInt(7, book.getStockQuantity());
                ps.setInt(8, book.getBookId());
                ps.executeUpdate();
            }

            // Updating authors
            updateRelations(connection, book.getBookId(), "Author_Book", authorIds);
            
            // Updating categories
            updateRelations(connection, book.getBookId(), "Book_Category", categoryIds);

            connection.commit();
            
        } catch (SQLException e) {
            if (connection != null) connection.rollback();
            throw e;
        } finally {
            if (connection != null) connection.close();
        }
    }

    private void updateRelations(Connection conn, int bookId, String table, List<Integer> ids) 
            throws SQLException {
        // Deleting existing relations
        String deleteSql = "DELETE FROM " + table + " WHERE Book_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(deleteSql)) {
            ps.setInt(1, bookId);
            ps.executeUpdate();
        }

        // Inserting new relations
        if (ids != null && !ids.isEmpty()) {
            String insertSql = "INSERT INTO " + table + " (Book_id, " + 
                             (table.equals("Author_Book") ? "Author_id" : "Category_id") + 
                             ") VALUES (?, ?)";
            try (PreparedStatement ps = conn.prepareStatement(insertSql)) {
                for (int id : ids) {
                    ps.setInt(1, bookId);
                    ps.setInt(2, id);
                    ps.addBatch();
                }
                ps.executeBatch();
            }
        }
    }

    public void deleteBook(int bookId) throws SQLException, ClassNotFoundException {
        try (Connection conn = DbConfig.getDbConnection()) {
            // Deleting from junction tables first
            String[] tables = {"Author_Book", "Book_Category"};
            for (String table : tables) {
                try (PreparedStatement ps = conn.prepareStatement(
                    "DELETE FROM " + table + " WHERE Book_id = ?")) {
                    ps.setInt(1, bookId);
                    ps.executeUpdate();
                }
            }
            
            // Deleting from main table
            try (PreparedStatement ps = conn.prepareStatement(
                "DELETE FROM Books WHERE Book_id = ?")) {
                ps.setInt(1, bookId);
                ps.executeUpdate();
            }
        }
    }
    
    
    
    
    
 // In BookDAO.java
    public List<Book> getPaginatedBooks(int page, int size) throws SQLException, ClassNotFoundException {
        Connection connection = DbConfig.getDbConnection();
        int offset = (page - 1) * size;
        String sql = "SELECT b.Book_id, b.Book_Title, b.Book_coverimageurl, b.Book_price, " +
                     "b.Book_description, b.Book_isbn, b.Publication_date, b.Book_stockquantity, " +
                     "a.Author_id, a.Author_name, c.Category_id, c.Category_name " +
                     "FROM Books b " +
                     "LEFT JOIN Author_Book ab ON b.Book_id = ab.Book_id " +
                     "LEFT JOIN Author a ON ab.Author_id = a.Author_id " +
                     "LEFT JOIN Book_Category bc ON b.Book_id = bc.Book_id " +
                     "LEFT JOIN Category c ON bc.Category_id = c.Category_id " +
                     "ORDER BY b.Publication_date DESC " +
                     "LIMIT ? OFFSET ?";

        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setInt(1, size);
        ps.setInt(2, offset);
        ResultSet rs = ps.executeQuery();

        Map<Integer, Book> bookMap = new HashMap<>();
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
                book.setCategories(new ArrayList<>());
                bookMap.put(bookId, book);
            }

            // Add authors
            int authorId = rs.getInt("Author_id");
            if (authorId > 0) {
                Author author = new Author(
                    authorId,
                    rs.getString("Author_name"),
                    "", ""
                );
                if (!book.getAuthors().contains(author)) {
                    book.getAuthors().add(author);
                }
            }

            // Add categories
            int categoryId = rs.getInt("Category_id");
            if (categoryId > 0) {
                Category category = new Category(
                    categoryId,
                    rs.getString("Category_name")
                );
                if (!book.getCategories().contains(category)) {
                    book.getCategories().add(category);
                }
            }
        }

        rs.close();
        ps.close();
        connection.close();

        return new ArrayList<>(bookMap.values());
    }

    public int getTotalBookCount() throws SQLException, ClassNotFoundException {
        Connection connection = DbConfig.getDbConnection();
        String sql = "SELECT COUNT(*) FROM Books";
        PreparedStatement ps = connection.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();
        rs.next();
        int count = rs.getInt(1);
        
        rs.close();
        ps.close();
        connection.close();
        
        return count;
    }
    
    
 // In BookDAO.java
    public List<Book> searchBooks(String query, int page, int size) throws SQLException, ClassNotFoundException {
        Connection connection = DbConfig.getDbConnection();
        int offset = (page - 1) * size;
        
        String sql = "SELECT b.* FROM Books b WHERE " +
                     "b.Book_id LIKE ? OR " +
                     "LOWER(b.Book_Title) LIKE LOWER(?) OR " +
                     "LOWER(b.Book_isbn) LIKE LOWER(?) " +
                     "ORDER BY b.Publication_date DESC " +
                     "LIMIT ? OFFSET ?";

        PreparedStatement ps = connection.prepareStatement(sql);
        String searchTerm = "%" + query + "%";
        ps.setString(1, searchTerm);
        ps.setString(2, searchTerm);
        ps.setString(3, searchTerm);
        ps.setInt(4, size);
        ps.setInt(5, offset);

        ResultSet rs = ps.executeQuery();
        List<Book> books = new ArrayList<>();

        while (rs.next()) {
            Book book = mapResultSetToBook(rs);
            book.setCategories(getCategoriesForBook(connection, book.getBookId()));
            books.add(book);
        }

        rs.close();
        ps.close();
        connection.close();

        return books;
    }

    public int getSearchCount(String query) throws SQLException, ClassNotFoundException {
        Connection connection = DbConfig.getDbConnection();
        String sql = "SELECT COUNT(*) FROM Books WHERE " +
                     "Book_id LIKE ? OR " +
                     "LOWER(Book_Title) LIKE LOWER(?) OR " +
                     "LOWER(Book_isbn) LIKE LOWER(?)";
        
        PreparedStatement ps = connection.prepareStatement(sql);
        String searchTerm = "%" + query + "%";
        ps.setString(1, searchTerm);
        ps.setString(2, searchTerm);
        ps.setString(3, searchTerm);
        
        ResultSet rs = ps.executeQuery();
        rs.next();
        int count = rs.getInt(1);
        
        rs.close();
        ps.close();
        connection.close();
        
        return count;
    }
    
  
}
    
    
   