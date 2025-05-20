package com.bookstore.model;



import java.util.List;


public class Cart {
 private int cartId;
 private int userId;
 private List<CartItem> items;

 // constructors, getters, setters
 public Cart() {}
 public Cart(int cartId, int userId, List<CartItem> items) {
     this.cartId = cartId;
     this.userId = userId;
     this.items = items;
 }
 
public int getCartId() {
	return cartId;
}
public void setCartId(int cartId) {
	this.cartId = cartId;
}
public int getUserId() {
	return userId;
}
public void setUserId(int userId) {
	this.userId = userId;
}
public List<CartItem> getItems() {
	return items;
}
public void setItems(List<CartItem> items) {
	this.items = items;
}


}
