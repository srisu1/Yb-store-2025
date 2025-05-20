package com.bookstore.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

import com.bookstore.model.Book;
import com.bookstore.dao.BookDAO;

@WebServlet("/search")
public class SearchController extends HttpServlet {
    private BookDAO bookDAO;

    public void init() {
        bookDAO = new BookDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String query = request.getParameter("query");

        if (query != null && !query.trim().isEmpty()) {
            try {
                List<Book> searchResults = bookDAO.searchBooks(query, 1, 20);
                request.getSession().setAttribute("searchResults", searchResults); // Use session to persist across redirect
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        // Use referer to go back to the page where the modal was opened
        String referer = request.getHeader("referer");

        if (referer == null || referer.isEmpty()) {
            referer = request.getContextPath() + "/home";
        }

        response.sendRedirect(referer);  // Redirect back to the same page
    }
}

