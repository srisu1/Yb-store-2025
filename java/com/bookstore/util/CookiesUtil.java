package com.bookstore.util;

import com.bookstore.model.User;
import com.bookstore.dao.UserDAO;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.net.URLDecoder;

public class CookiesUtil {
    private static final int REMEMBER_ME_AGE = 7 * 24 * 60 * 60; // 1 week
    private static final boolean SECURE_COOKIES = Boolean.parseBoolean(
        System.getenv().getOrDefault("COOKIE_SECURE", "false")
    );
    private static final String SAME_SITE = "Lax";
    private static final String ENCODING = "UTF-8";

    // Create remember-me cookie
    public static void createRememberMeCookie(HttpServletResponse response, String email) {
        try {
            String encodedEmail = encodeCookieValue(email);
            String cookieValue = String.format("rememberMe=%s; Max-Age=%d; Path=/; %s; HttpOnly; SameSite=%s",
                encodedEmail,
                REMEMBER_ME_AGE,
                SECURE_COOKIES ? "Secure" : "",
                SAME_SITE);

            response.addHeader("Set-Cookie", cookieValue);
        } catch (UnsupportedEncodingException e) {
            throw new RuntimeException("UTF-8 encoding not supported", e);
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
                        throw new RuntimeException("UTF-8 decoding not supported", e);
                    }
                }
            }
        }
        return null;
    }

    // Delete cookie
    public static void deleteCookie(HttpServletResponse response, String name) {
        String cookieValue = String.format("%s=; Max-Age=0; Path=/; %s; HttpOnly; SameSite=%s",
            name,
            SECURE_COOKIES ? "Secure" : "",
            SAME_SITE);
        
        response.addHeader("Set-Cookie", cookieValue);
    }

    // Cookie value encoding
    private static String encodeCookieValue(String value) throws UnsupportedEncodingException {
        return URLEncoder.encode(value, ENCODING);
    }

    // Cookie value decoding
    private static String decodeCookieValue(String value) throws UnsupportedEncodingException {
        return URLDecoder.decode(value, ENCODING);
    }

    // Refresh session from remember-me cookie
    public static void refreshSessionFromCookie(HttpServletRequest request, UserDAO userDAO) {
        String email = getCookieValue(request, "rememberMe");
        if (email != null && !SessionUtil.isUserLoggedIn(request)) {
            User user = userDAO.getUserByEmail(email);
            if (user != null) {
                SessionUtil.createUserSession(request, user);
            }
        }
    }
}