package com.bookstore.controller;

import com.bookstore.config.DbConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/update-views")
public class ViewCounterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) {
        String bookId = request.getParameter("bookId");
        if (bookId == null || bookId.isEmpty()) return;

        try (Connection conn = DbConfig.getDbConnection()) {
            String sql = "UPDATE books SET weekly_views = weekly_views + 1 WHERE book_id = ?";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, Integer.parseInt(bookId));
                ps.executeUpdate();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}