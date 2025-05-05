package com.bookstore.controller;

import com.bookstore.dao.BookDAO;
import com.bookstore.dao.CategoryDAO;
import com.bookstore.model.Book;
import com.bookstore.model.Category;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/pages/*")
public class PageController extends HttpServlet {
    private BookDAO bookDAO;
    private CategoryDAO categoryDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        bookDAO = new BookDAO();
        categoryDAO = new CategoryDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Load common data needed for all pages
            List<Book> booksOfWeek = bookDAO.getBooksOfTheWeek();
            List<Category> categories = categoryDAO.getAllCategories();

            // Set attributes for header/footer
            request.setAttribute("booksOfWeek", booksOfWeek);
            request.setAttribute("categories", categories);

            // Determine which page to show
            String path = request.getPathInfo();
            String page = determinePage(path);

            if (page == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
                return;
            }

            request.getRequestDispatcher(page).forward(request, response);

        } catch (Exception e) {
            throw new ServletException("Error loading page data", e);
        }
    }

    private String determinePage(String path) {
        if (path == null || path.equals("/") || path.equals("/home")) {
            return "/WEB-INF/pages/home.jsp";
        }
        if (path.equals("/about")) {
            return "/WEB-INF/pages/about.jsp";
        }
        if (path.equals("/contact")) {
            return "/WEB-INF/pages/Contact.jsp";
        }
        return null;
    }
}