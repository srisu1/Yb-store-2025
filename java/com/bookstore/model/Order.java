package com.bookstore.model;

import java.sql.Timestamp;
import java.util.List;

public class Order {
    private int orderId;          // maps to Order_id
    private int userId;           // maps to User_id
    private Timestamp orderDate;  // maps to Order_date
    private double totalAmount;   // maps to Total_amount
    private String orderStatus;   // maps to Order_status

    // List of items in this order
    private List<OrderItem> items;

    // Getters and setters
    public int getOrderId() {
        return orderId;
    }
    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }
    public int getUserId() {
        return userId;
    }
    public void setUserId(int userId) {
        this.userId = userId;
    }
    public Timestamp getOrderDate() {
        return orderDate;
    }
    public void setOrderDate(Timestamp orderDate) {
        this.orderDate = orderDate;
    }
    public double getTotalAmount() {
        return totalAmount;
    }
    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }
    public String getOrderStatus() {
        return orderStatus;
    }
    public void setOrderStatus(String orderStatus) {
        this.orderStatus = orderStatus;
    }
    public List<OrderItem> getItems() {
        return items;
    }
    public void setItems(List<OrderItem> items) {
        this.items = items;
    }
}
