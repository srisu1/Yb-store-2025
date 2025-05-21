package com.bookstore.util;

import com.bookstore.model.User;
import com.bookstore.dao.UserDAO;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.sql.SQLException;
import java.net.URLDecoder;

public class CookiesUtil {
    private static final int REMEMBER_ME_AGE = 60 * 60; // 1 hour
    private static final boolean SECURE_COOKIES = Boolean.parseBoolean(
        System.getenv().getOrDefault("COOKIE_SECURE", "false")
    );
    private static final String SAME_SITE = "Lax"; // Critical for cookie security
    private static final String ENCODING = "UTF-8";

    // Create remember-me cookie (with SameSite)
    public static void createRememberMeCookie(HttpServletResponse response, String email) {
        try {
            String cookieValue = String.format(
                "rememberMe=%s; Max-Age=%d; Path=/; %s; HttpOnly; SameSite=%s",
                encodeCookieValue(email),
                REMEMBER_ME_AGE,
                SECURE_COOKIES ? "Secure" : "",
                SAME_SITE
            );
            response.addHeader("Set-Cookie", cookieValue);
        } catch (UnsupportedEncodingException e) {
            throw new RuntimeException("UTF-8 encoding error", e);
        }
    }

    // Get cookie value by name
    public static String getCookieValue(HttpServletRequest request, String name) {
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals(name)) {
                    try {
                        return decodeCookieValue(cookie.getValue());
                    } catch (UnsupportedEncodingException e) {
                        throw new RuntimeException("UTF-8 decoding error", e);
                    }
                }
            }
        }
        return null;
    }

    // Delete cookie with SameSite attributes
    public static void deleteCookie(HttpServletResponse response, String name) {
        String cookieValue = String.format(
            "%s=; Max-Age=0; Path=/; %s; HttpOnly; SameSite=%s",
            name,
            SECURE_COOKIES ? "Secure" : "",
            SAME_SITE
        );
        response.addHeader("Set-Cookie", cookieValue);
    }

    private static String encodeCookieValue(String value) throws UnsupportedEncodingException {
        return URLEncoder.encode(value, ENCODING);
    }

    private static String decodeCookieValue(String value) throws UnsupportedEncodingException {
        return URLDecoder.decode(value, ENCODING);
    }

    // Refresh session from remember-me cookie
    public static void refreshSessionFromCookie(HttpServletRequest request, UserDAO userDAO) {
        String email = getCookieValue(request, "rememberMe");
        if (email != null && !SessionUtil.isUserLoggedIn(request)) {
            try {
                User user = userDAO.getUserByEmail(email);
                if (user != null) {
                    SessionUtil.createUserSession(request, user);
                }
            } catch (SQLException e) {
                // handle or log error
                e.printStackTrace();
            }
        }
    }

}