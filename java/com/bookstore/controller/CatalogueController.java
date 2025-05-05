package com.bookstore.controller;

import com.bookstore.config.DbConfig;
import com.bookstore.dao.BookDAO;
import com.bookstore.dao.CategoryDAO;
import com.bookstore.model.Book;
import com.bookstore.model.Category;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/catalog")
public class CatalogueController extends HttpServlet {
    
    private final CategoryDAO categoryDao = new CategoryDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {

        String categoryId = request.getParameter("categoryId");
        Connection connection = null;

        try {
        	BookDAO bookDAO = new BookDAO();
        	List<Book> booksOfWeek = bookDAO.getBooksOfTheWeek(); // Fetch books of the week
        	request.setAttribute("booksOfWeek", booksOfWeek); // 
        	
            connection = DbConfig.getDbConnection();
           
            
            // Get all categories for filter panel
            List<Category> categories = categoryDao.getAllCategories();
            request.setAttribute("categories", categories);

            List<Book> books;
            if (categoryId != null && !categoryId.isEmpty()) {
                books = bookDAO.getBooksByCategory(connection, categoryId);
            } else {
                books = bookDAO.getAllBooksWithAuthors();
            }

            request.setAttribute("books", books);
            request.getRequestDispatcher("/WEB-INF/pages/catalog.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error loading catalog");
        } finally {
            if (connection != null) {
                try { connection.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        }
    }
}