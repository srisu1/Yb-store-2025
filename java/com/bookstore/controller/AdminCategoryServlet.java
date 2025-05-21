package com.bookstore.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import com.bookstore.dao.CategoryDAO;
import com.bookstore.model.Category;

@WebServlet("/CategoryServlet")
public class AdminCategoryServlet extends HttpServlet {
    private final CategoryDAO categoryDAO = new CategoryDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        try {
            if ("edit".equals(action)) {
                int categoryId = Integer.parseInt(request.getParameter("id"));
                Category category = categoryDAO.getCategoryById(categoryId);
                request.setAttribute("category", category);

                List<Category> categories = categoryDAO.getAllCategories();
                request.setAttribute("categories", categories);
                request.setAttribute("contentPage", "/WEB-INF/pages/admin_category.jsp");
                request.getRequestDispatcher("/WEB-INF/pages/adminpanel.jsp").forward(request, response);

            } else if ("delete".equals(action)) {
                int categoryId = Integer.parseInt(request.getParameter("id"));
                categoryDAO.deleteCategory(categoryId);

                // Redirect to adminpanel after delete to reload all data and avoid stale state
                response.sendRedirect(request.getContextPath() + "/adminpanel");
            } else {
                // Default: just load categories and forward
                List<Category> categories = categoryDAO.getAllCategories();
                request.setAttribute("categories", categories);
                request.setAttribute("contentPage", "/WEB-INF/pages/admin_category.jsp");
                request.getRequestDispatcher("/WEB-INF/pages/adminpanel.jsp").forward(request, response);
            }

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        try {
            if ("add".equals(action)) {
                String name = request.getParameter("categoryName");
                categoryDAO.addCategory(new Category(0, name));
            } else if ("update".equals(action)) {
                int categoryId = Integer.parseInt(request.getParameter("categoryId"));
                String name = request.getParameter("categoryName");
                categoryDAO.updateCategory(new Category(categoryId, name));
            }

            // Redirect to adminpanel after add or update to reload all data and avoid resubmission
            response.sendRedirect(request.getContextPath() + "/adminpanel");

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error");
        }
    }
}
