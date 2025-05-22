package com.bookstore.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.bookstore.dao.UserDAO;
import com.bookstore.model.User;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/AdminUserServlet")
public class AdminUserServlet extends HttpServlet {
    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            if ("editRole".equals(action)) {
                int userId = Integer.parseInt(request.getParameter("userId"));
                User user = userDAO.getUserById(userId);
                request.getSession().setAttribute("userToEdit", user); // store user to edit in session
                // Redirect to adminpanel to load all data and show edit UI there
                response.sendRedirect(request.getContextPath() + "/adminpanel?action=editUser");
                return;
            } else if ("delete".equals(action)) {
                int userId = Integer.parseInt(request.getParameter("userId"));
                userDAO.deleteUser(userId);
                // After delete, redirect to admin panel to refresh data
                response.sendRedirect(request.getContextPath() + "/adminpanel");
                return;
            }

            // Default redirect to adminpanel for consistency
            response.sendRedirect(request.getContextPath() + "/adminpanel");

        } catch (SQLException | NumberFormatException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "An error occurred while managing users: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/pages/error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            if ("updateRole".equals(action)) {
                int userId = Integer.parseInt(request.getParameter("userId"));
                String newRole = request.getParameter("role");

                User user = userDAO.getUserById(userId);
                if (user != null) {
                    user.setRole(newRole);
                    userDAO.updateUserRole(user);
                }
                // Clear the edit user session attribute after update
                request.getSession().removeAttribute("userToEdit");
            }

            // After update, redirect to adminpanel to refresh and show updated data
            response.sendRedirect(request.getContextPath() + "/adminpanel");

        } catch (SQLException | NumberFormatException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "An error occurred while updating user role: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/pages/error.jsp").forward(request, response);
        }
    }
}
