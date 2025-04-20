package com.bookstore.controller;

import com.bookstore.dao.UserDAO;
import com.bookstore.model.User;
import com.bookstore.util.PasswordUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;


@WebServlet("/login")
public class LoginServlet extends HttpServlet {
	 private static final long serialVersionUID = 1L;

    // Handle GET requests (e.g., when someone tries to access /login directly)
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Redirect to home page with login modal trigger
    	response.getWriter().write("GET method is not allowed for login");
    	
        response.sendRedirect(request.getContextPath() + "/home?showLogin=true");
    }

    // Handle POST requests (form submissions)
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String rememberMe = request.getParameter("rememberMe");

        try {
            UserDAO userDAO = new UserDAO();
            User user = userDAO.getUserByEmail(email);

            if (user != null && PasswordUtil.checkPassword(password, user.getPasswordHash())) {
                // Create session
                HttpSession session = request.getSession();
                System.out.println("Session created for user: " + user.getEmail());
                session.setAttribute("user", user);
               

                // Handle remember-me cookie
                if (rememberMe != null) {
                    Cookie cookie = new Cookie("rememberMe", email);
                    cookie.setMaxAge(7 * 24 * 60 * 60); // 1 week
                    response.addCookie(cookie);
                }

                // Role-based redirect
                if ("admin".equalsIgnoreCase(user.getRole())) {
                    response.sendRedirect(request.getContextPath() + "/admin");
                } else {
                    response.sendRedirect(request.getContextPath() + "/home");
                }
            } else {
                request.setAttribute("error", "Invalid email or password");
                // Forward to home controller instead of direct JSP
                request.getRequestDispatcher("/home").forward(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("error", "Login error: " + e.getMessage());
            // Forward to home controller instead of direct JSP
            request.getRequestDispatcher("/home").forward(request, response);
        }
    }
}