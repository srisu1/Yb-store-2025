package com.bookstore.controller;

import jakarta.servlet.ServletException;


import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

import com.bookstore.config.DbConfig;
import com.bookstore.dao.AuthorDAO;
import com.bookstore.model.Author;


@WebServlet("/AdminAuthorServlet")
public class AdminAuthorServlet extends HttpServlet {
    private AuthorDAO authorDAO = new AuthorDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("edit".equals(action)) {
            int authorId = Integer.parseInt(request.getParameter("id"));
            Author author = authorDAO.getAuthorById(authorId);
            request.setAttribute("author", author);
        } else if ("delete".equals(action)) {
            int authorId = Integer.parseInt(request.getParameter("id"));
            authorDAO.deleteAuthor(authorId);
        }

        // Always load authors list and forward to layout
        List<Author> authors = authorDAO.getAllAuthors();
        request.setAttribute("authors", authors);
        request.setAttribute("contentPage", "/WEB-INF/pages/admin_people.jsp");
        request.getRequestDispatcher("/WEB-INF/pages/adminpanel.jsp").forward(request, response);

    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getParameter("action");

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

        // Reload updated authors and forward to layout
        List<Author> authors = authorDAO.getAllAuthors();
        request.setAttribute("authors", authors);
        request.setAttribute("contentPage", "/WEB-INF/pages/admin_people.jsp");
        request.getRequestDispatcher("/WEB-INF/pages/adminpanel.jsp").forward(request, response);

    }
} 