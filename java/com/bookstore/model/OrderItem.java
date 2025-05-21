package com.bookstore.model;

public class OrderItem {
    private int orderItemId;      // maps to Order_itemid
    private int orderId;          // maps to Order_id
    private int bookId;           // maps to Book_id
    private int quantity;         // maps to Quantity
    private double priceAtOrder;  // maps to Price_atorder

    // Optional: Add book title or other book info if you want to display it with order items
    private String bookTitle;

    // Getters and setters
    public int getOrderItemId() {
        return orderItemId;
    }
    public void setOrderItemId(int orderItemId) {
        this.orderItemId = orderItemId;
    }
    public int getOrderId() {
        return orderId;
    }
    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }
    public int getBookId() {
        return bookId;
    }
    public void setBookId(int bookId) {
        this.bookId = bookId;
    }
    public int getQuantity() {
        return quantity;
    }
    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
    public double getPriceAtOrder() {
        return priceAtOrder;
    }
    public void setPriceAtOrder(double priceAtOrder) {
        this.priceAtOrder = priceAtOrder;
    }
    public String getBookTitle() {
        return bookTitle;
    }
    public void setBookTitle(String bookTitle) {
        this.bookTitle = bookTitle;
    }
}
