package com.bookstore.model;



public class CartItem {
 private int cartItemId;
 private int cartId;
 private int bookId;
 private String bookTitle;
 private String bookCoverUrl; // optional for displaying image
 private int quantity;
 private double price; // price per unit

 // constructors, getters, setters
 public CartItem() {}
 public CartItem(int cartItemId, int cartId, int bookId, String bookTitle, String bookCoverUrl, int quantity, double price) {
     this.cartItemId = cartItemId;
     this.cartId = cartId;
     this.bookId = bookId;
     this.bookTitle = bookTitle;
     this.bookCoverUrl = bookCoverUrl;
     this.quantity = quantity;
     this.price = price;
 }

 
 
 public int getCartItemId() {
	return cartItemId;
}
public void setCartItemId(int cartItemId) {
	this.cartItemId = cartItemId;
}
public int getCartId() {
	return cartId;
}
public void setCartId(int cartId) {
	this.cartId = cartId;
}
public int getBookId() {
	return bookId;
}
public void setBookId(int bookId) {
	this.bookId = bookId;
}
public String getBookTitle() {
	return bookTitle;
}
public void setBookTitle(String bookTitle) {
	this.bookTitle = bookTitle;
}
public String getBookCoverUrl() {
	return bookCoverUrl;
}
public void setBookCoverUrl(String bookCoverUrl) {
	this.bookCoverUrl = bookCoverUrl;
}
public int getQuantity() {
	return quantity;
}
public void setQuantity(int quantity) {
	this.quantity = quantity;
}
public double getPrice() {
	return price;
}
public void setPrice(double price) {
	this.price = price;
}

public double getTotalPrice() {
     return price * quantity;
 }
}
