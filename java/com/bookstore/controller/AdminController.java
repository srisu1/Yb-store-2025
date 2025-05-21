package com.bookstore.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import com.bookstore.dao.*;
import com.bookstore.model.*;

@WebServlet("/adminpanel")
public class AdminController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final CategoryDAO categoryDAO = new CategoryDAO();
    private final BookDAO bookDAO = new BookDAO();
    private final UserDAO userDAO = new UserDAO();
    private final AuthorDAO authorDAO = new AuthorDAO();
    private final OrderDAO orderDAO = new OrderDAO();


    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            List<Category> categories = categoryDAO.getAllCategories();
            List<Book> books = bookDAO.getAllBooksWithAuthors();
            List<User> users = userDAO.getAllUsers();
            List<Author> authors = authorDAO.getAllAuthors();
            List<Order> orders = orderDAO.getAllOrders();  // Load orders

            request.setAttribute("categories", categories);
            request.setAttribute("books", books);
            request.setAttribute("users", users);
            request.setAttribute("authors", authors);
            request.setAttribute("orders", orders);  // Set orders attribute

            // Determine which admin page to show; default to dashboard or categories
            String adminPage = request.getParameter("page");
            if (adminPage == null || adminPage.isEmpty()) {
                adminPage = "dashboard";  // or "categories"
            }
            request.setAttribute("adminPage", adminPage);

            request.getRequestDispatcher("/WEB-INF/pages/adminpanel.jsp").forward(request, response);

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error");
        }
    }
}