package com.bookstore.dao;

import com.bookstore.config.DbConfig;
import com.bookstore.model.Order;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {
    private Connection conn;

    // No-arg constructor that initializes the DB connection
    public OrderDAO() {
        try {
            this.conn = DbConfig.getDbConnection();
        } catch (SQLException e) {
            throw new RuntimeException("Failed to establish database connection in OrderDAO", e);
        }
    }

    // Optional: constructor for manually passing a connection
    public OrderDAO(Connection conn) {
        this.conn = conn;
    }

    public List<Order> getAllOrders() throws SQLException {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT * FROM Orders ORDER BY Order_date DESC LIMIT 20"; // Limit added

        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Order order = extractOrderFromResultSet(rs);
                orders.add(order);
            }
        }
        return orders;
    }


    public List<Order> getOrdersByFilter(Timestamp startDate, Timestamp endDate, String status) throws SQLException {
        List<Order> orders = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM Orders WHERE 1=1");

        if (startDate != null) sql.append(" AND Order_date >= ?");
        if (endDate != null) sql.append(" AND Order_date <= ?");
        if (status != null && !status.isEmpty()) sql.append(" AND Order_status = ?");
        sql.append(" ORDER BY Order_date DESC");

        try (PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            int index = 1;
            if (startDate != null) ps.setTimestamp(index++, startDate);
            if (endDate != null) ps.setTimestamp(index++, endDate);
            if (status != null && !status.isEmpty()) ps.setString(index, status);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    orders.add(extractOrderFromResultSet(rs));
                }
            }
        }
        return orders;
    }

    public double getTotalSales(Timestamp startDate, Timestamp endDate) throws SQLException {
        String sql = "SELECT SUM(Total_amount) AS totalSales FROM Orders WHERE Order_date BETWEEN ? AND ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setTimestamp(1, startDate);
            ps.setTimestamp(2, endDate);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getDouble("totalSales");
                }
            }
        }
        return 0;
    }

    private Order extractOrderFromResultSet(ResultSet rs) throws SQLException {
        Order order = new Order();
        order.setOrderId(rs.getInt("Order_id"));
        order.setUserId(rs.getInt("User_id"));
        order.setOrderDate(rs.getTimestamp("Order_date"));
        order.setTotalAmount(rs.getDouble("Total_amount"));
        order.setOrderStatus(rs.getString("Order_status"));
        return order;
    }
}
