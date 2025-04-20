package com.bookstore.util;

import com.bookstore.model.User;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

public class SessionUtil {
    private static final int SESSION_TIMEOUT = 30 * 60; // 30 minutes

    // Create or update user session
    public static void createUserSession(HttpServletRequest request, User user) {
        HttpSession session = request.getSession();
        session.setMaxInactiveInterval(SESSION_TIMEOUT);
        session.setAttribute("user", user);
        session.setAttribute("role", user.getRole());
    }

    // Get current user from session
    public static User getCurrentUser(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        return (session != null) ? (User) session.getAttribute("user") : null;
    }

    // Check if user is logged in
    public static boolean isUserLoggedIn(HttpServletRequest request) {
        return getCurrentUser(request) != null;
    }

    // Check if user has admin role
    public static boolean isUserAdmin(HttpServletRequest request) {
        User user = getCurrentUser(request);
        return user != null && "admin".equalsIgnoreCase(user.getRole());
    }

    // Invalidate session
    public static void invalidateSession(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
    }
}