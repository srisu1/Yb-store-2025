package com.bookstore.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import com.bookstore.dao.*;
import com.bookstore.model.*;

@WebServlet("/AdminAuthorServlet")
public class AdminAuthorServlet extends HttpServlet {
    private final AuthorDAO authorDAO = new AuthorDAO();
    private final CategoryDAO categoryDAO = new CategoryDAO();
    private final BookDAO bookDAO = new BookDAO();
    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        try {
            if ("edit".equals(action)) {
                int authorId = Integer.parseInt(request.getParameter("id"));
                Author author = authorDAO.getAuthorById(authorId);
                request.setAttribute("author", author);

                // Load ALL other data like AdminController does, so page is consistent
                List<Category> categories = categoryDAO.getAllCategories();
                List<Book> books = bookDAO.getAllBooksWithAuthors();
                List<User> users = userDAO.getAllUsers();
                List<Author> authors = authorDAO.getAllAuthors();

                request.setAttribute("categories", categories);
                request.setAttribute("books", books);
                request.setAttribute("users", users);
                request.setAttribute("authors", authors);

                // Set content page for authors tab or section
                request.setAttribute("contentPage", "/WEB-INF/pages/admin_people.jsp");

                request.getRequestDispatcher("/WEB-INF/pages/adminpanel.jsp").forward(request, response);

            } else if ("delete".equals(action)) {
                int authorId = Integer.parseInt(request.getParameter("id"));
                authorDAO.deleteAuthor(authorId);

                // Redirect to /adminpanel so all data loads fresh
                response.sendRedirect(request.getContextPath() + "/adminpanel");

            } else {
                // For default GET, redirect to /adminpanel to show all data, not just authors
                response.sendRedirect(request.getContextPath() + "/adminpanel");
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        try {
            if ("add".equals(action)) {
                String name = request.getParameter("name");
                String bio = request.getParameter("bio");
                String email = request.getParameter("email");
                authorDAO.addAuthor(new Author(0, name, bio, email));

            } else if ("update".equals(action)) {
                int authorId = Integer.parseInt(request.getParameter("authorId"));
                String name = request.getParameter("name");
                String bio = request.getParameter("bio");
                String email = request.getParameter("email");
                authorDAO.updateAuthor(new Author(authorId, name, bio, email));
            }

            // After add/update redirect to /adminpanel for fresh load of all data
            response.sendRedirect(request.getContextPath() + "/adminpanel");

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error");
        }
    

 }
}
