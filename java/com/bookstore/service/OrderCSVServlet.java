package com.bookstore.service;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import com.bookstore.dao.OrderDAO;
import com.bookstore.model.Order;

@WebServlet("/downloadOrderCSV")
public class OrderCSVServlet extends HttpServlet {
    
    private OrderDAO orderDAO;

    @Override
    public void init() {
        orderDAO = new OrderDAO();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
    	System.out.println("OrderCSVServlet.doGet() called");

        resp.setContentType("text/csv");
        resp.setHeader("Content-Disposition", "attachment; filename=orders_report.csv");

        try (PrintWriter writer = resp.getWriter()) {
            // Write CSV header
            writer.println("Order ID,User ID,Order Date,Status,Total Amount");

            List<Order> orders = orderDAO.getAllOrders();

            for (Order order : orders) {
                writer.printf("%d,%d,%s,%s,%.2f\n",
                    order.getOrderId(),
                    order.getUserId(),
                    order.getOrderDate() != null ? order.getOrderDate().toString() : "",
                    order.getOrderStatus(),
                    order.getTotalAmount());
            }
        } catch (Exception e) {
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error generating CSV report");
        }
    }
}
