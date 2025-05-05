package com.bookstore.controller;

import com.bookstore.config.DbConfig;
import com.bookstore.dao.BookDAO;
import com.bookstore.dao.RelatedBookDAO;
import com.bookstore.dao.ReviewDAO;
import com.bookstore.model.Book;
import com.bookstore.model.Review;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.List;

@WebServlet("/bookdetails")
public class BookDetailsController extends HttpServlet {

    private static final long serialVersionUID = 1L;

	@Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int bookId = Integer.parseInt(request.getParameter("id"));
        Connection connection = null;

        // Start of view tracking addition
        try {
        	
        	
            // Create separate connection for view tracking
            Connection viewConn = DbConfig.getDbConnection();
            
            BookDAO bookDAO = new BookDAO();
        	List<Book> booksOfWeek = bookDAO.getBooksOfTheWeek(); // Fetch books of the week
        	request.setAttribute("booksOfWeek", booksOfWeek); // 
        	
            String updateViewSQL = "UPDATE books SET weekly_views = weekly_views + 1 WHERE book_id = ?";
            try (PreparedStatement ps = viewConn.prepareStatement(updateViewSQL)) {
                ps.setInt(1, bookId);
                ps.executeUpdate();
            }
            viewConn.close();
        } catch (Exception e) {
            e.printStackTrace(); // Log error but continue loading page
        }
        // End of view tracking addition

        try {
            connection = DbConfig.getDbConnection();
            BookDAO bookDAO = new BookDAO();
            Book book = bookDAO.getBookById(bookId);

            RelatedBookDAO relatedBookDAO = new RelatedBookDAO(connection);
            List<Book> relatedBooks = relatedBookDAO.getRelatedBooksWithDetails(bookId, 4);

            ReviewDAO reviewDAO = new ReviewDAO(connection);
            List<Review> reviews = reviewDAO.getReviews(bookId);
            
            double averageRating = reviewDAO.getAverageRatingForBook(bookId);

            request.setAttribute("book", book);
            request.setAttribute("relatedBooks", relatedBooks);
            request.setAttribute("reviews", reviews);
            request.setAttribute("averageRating", averageRating);

            request.getRequestDispatcher("/WEB-INF/pages/bookdetails.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error loading book details");
        } finally {
            if (connection != null) {
                try { connection.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Existing doPost code remains unchanged
        int bookId = Integer.parseInt(request.getParameter("bookId"));
        int rating = Integer.parseInt(request.getParameter("rating"));
        String reviewText = request.getParameter("reviewText");
        int userId = 1;

        Review review = new Review(0, rating, reviewText, new Timestamp(System.currentTimeMillis()), "Pending");

        Connection connection = null;

        try {
            connection = DbConfig.getDbConnection();
            ReviewDAO reviewDAO = new ReviewDAO(connection);
            reviewDAO.addReview(review, bookId, userId);
            response.sendRedirect("bookdetails?id=" + bookId);

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error submitting review");
        } finally {
            if (connection != null) {
                try { connection.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        }
    }
}
