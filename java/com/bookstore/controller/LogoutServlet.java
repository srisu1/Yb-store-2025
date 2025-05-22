package com.bookstore.controller;

import com.bookstore.util.CookiesUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {
	
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. Invalidate session FIRST
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }

        // 2. Create a new session just to store the logout message
        HttpSession newSession = request.getSession(true);
        newSession.setAttribute("logoutMessage", "You have successfully logged out.");

        // 3. Delete cookies using header-based method
        CookiesUtil.deleteCookie(response, "rememberMe");
        CookiesUtil.deleteCookie(response, "userLoggedIn");

        // 4. Prevent caching
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);

        // 5. Redirect
        response.sendRedirect(request.getContextPath() + "/home");
    }
}
