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

    @Override
    public void init() {
        bookDAO = new BookDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String query = request.getParameter("query");
        HttpSession session = request.getSession();

        if (query != null && !query.trim().isEmpty()) {
            try {
                List<Book> searchResults = bookDAO.searchBooks(query.trim(), 1, 20);
                session.setAttribute("searchResults", searchResults); // Store results in session for modal use
                session.setAttribute("searchQuery", query.trim());   // Optionally keep query too
            } catch (Exception e) {
                e.printStackTrace();
                session.setAttribute("searchError", "Error during search. Please try again.");
            }
        } else {
            session.setAttribute("searchError", "Search query cannot be empty.");
        }

        // Redirect back to the previous page (where modal was triggered)
        String referer = request.getHeader("referer");
        if (referer == null || referer.isEmpty()) {
            referer = request.getContextPath() + "/home";
        }

        response.sendRedirect(referer);
    }
}
