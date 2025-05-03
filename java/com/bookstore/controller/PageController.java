package com.bookstore.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/pages/*")
public class PageController extends HttpServlet {
    private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getPathInfo(); // e.g., /about or /home
        String page;

        if (path == null || path.equals("/") || path.equals("/home")) {
            page = "/WEB-INF/pages/home.jsp";
        } else if (path.equals("/about")) {
            page = "/WEB-INF/pages/about.jsp";
        } else if (path.equals("/contact")) {
            page = "/WEB-INF/pages/Contact.jsp";
        } else {
            // Optional 404 fallback
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        request.getRequestDispatcher(page).forward(request, response);
    }
}
