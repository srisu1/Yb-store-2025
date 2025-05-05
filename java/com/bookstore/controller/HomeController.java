package com.bookstore.controller;

import com.bookstore.dao.BookDAO;
import com.bookstore.dao.CategoryDAO; // Add this import
import com.bookstore.model.Book;
import com.bookstore.model.Category; // Add this import
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet(urlPatterns = {"/home", "/"})
public class HomeController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            BookDAO bookDAO = new BookDAO();
            CategoryDAO categoryDAO = new CategoryDAO(); // Initialize CategoryDAO
            
            List<Book> booksOfWeek = bookDAO.getBooksOfTheWeek(); //  Fetch books of the week
            request.setAttribute("booksOfWeek", booksOfWeek);     //  Set attribute


            // Existing book data
            List<Book> allBooks = bookDAO.getAllBooksWithAuthors();
            List<Book> bestSellers = bookDAO.getBestSellers();
            List<Book> newArrivals = bookDAO.getNewArrivals();
            
            // Get categories
            List<Category> categories = categoryDAO.getAllCategories(); // Fetch categories

            // Set attributes
            request.setAttribute("books", allBooks);
            request.setAttribute("bookList", allBooks);
            request.setAttribute("bestSellers", bestSellers);
            request.setAttribute("newArrivals", newArrivals);
            request.setAttribute("categories", categories); // Add categories to request

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            request.setAttribute("error", "Error loading data: " + e.getMessage());
        }

        request.getRequestDispatcher("/WEB-INF/pages/home.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}