package com.bookstore.dao;

import com.bookstore.model.Cart;
import com.bookstore.model.CartItem;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CartDAO {
    private Connection conn;

    public CartDAO(Connection conn) {
        this.conn = conn;
    }

    public Cart getCartByUserId(int userId) throws SQLException {
        Cart cart = null;

        // Get cart info
        String cartSql = "SELECT Cart_id, User_id FROM Cart WHERE User_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(cartSql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                cart = new Cart();
                cart.setCartId(rs.getInt("Cart_id"));
                cart.setUserId(rs.getInt("User_id"));
                cart.setItems(new ArrayList<>());

                // Load cart items with book info (title, coverimageurl, price)
                String itemsSql = "SELECT ci.Cart_itemid, ci.Book_id, ci.Cart_itemquantity, " +
                        "b.Book_Title, b.Book_coverimageurl, b.Book_price " +
                        "FROM CartItem ci " +
                        "JOIN Books b ON ci.Book_id = b.Book_id " +
                        "WHERE ci.Cart_id = ?";

                try (PreparedStatement psItems = conn.prepareStatement(itemsSql)) {
                    psItems.setInt(1, cart.getCartId());
                    ResultSet rsItems = psItems.executeQuery();

                    while (rsItems.next()) {
                        CartItem item = new CartItem();
                        item.setCartItemId(rsItems.getInt("Cart_itemid"));
                        item.setBookId(rsItems.getInt("Book_id"));
                        item.setQuantity(rsItems.getInt("Cart_itemquantity"));
                        item.setBookTitle(rsItems.getString("Book_Title"));
                        item.setBookCoverUrl(rsItems.getString("Book_coverimageurl"));  // Corrected column name
                        item.setPrice(rsItems.getDouble("Book_price"));
                        cart.getItems().add(item);
                    }
                }
            }
        }
        return cart;
    }

    public int createCartForUser(int userId) throws SQLException {
        String sql = "INSERT INTO Cart (User_id) VALUES (?)";
        try (PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, userId);
            ps.executeUpdate();
            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1); // new Cart_id
            }
        }
        return -1;
    }

    public void addOrUpdateCartItem(int cartId, int bookId, int quantity) throws SQLException {
        String checkSql = "SELECT Cart_itemid, Cart_itemquantity FROM CartItem WHERE Cart_id = ? AND Book_id = ?";
        try (PreparedStatement psCheck = conn.prepareStatement(checkSql)) {
            psCheck.setInt(1, cartId);
            psCheck.setInt(2, bookId);
            ResultSet rs = psCheck.executeQuery();
            if (rs.next()) {
                int existingQty = rs.getInt("Cart_itemquantity");
                int newQty = existingQty + quantity;
                int cartItemId = rs.getInt("Cart_itemid");

                String updateSql = "UPDATE CartItem SET Cart_itemquantity = ? WHERE Cart_itemid = ?";
                try (PreparedStatement psUpdate = conn.prepareStatement(updateSql)) {
                    psUpdate.setInt(1, newQty);
                    psUpdate.setInt(2, cartItemId);
                    psUpdate.executeUpdate();
                }
            } else {
                String insertSql = "INSERT INTO CartItem (Cart_id, Book_id, Cart_itemquantity) VALUES (?, ?, ?)";
                try (PreparedStatement psInsert = conn.prepareStatement(insertSql)) {
                    psInsert.setInt(1, cartId);
                    psInsert.setInt(2, bookId);
                    psInsert.setInt(3, quantity);
                    psInsert.executeUpdate();
                }
            }
        }
    }

    public void updateCartItemQuantity(int cartId, int bookId, int quantity) throws SQLException {
        String sql = "UPDATE CartItem SET Cart_itemquantity = ? WHERE Cart_id = ? AND Book_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, quantity);
            ps.setInt(2, cartId);
            ps.setInt(3, bookId);
            ps.executeUpdate();
        }
    }

    public void removeCartItem(int cartId, int bookId) throws SQLException {
        String sql = "DELETE FROM CartItem WHERE Cart_id = ? AND Book_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, cartId);
            ps.setInt(2, bookId);
            ps.executeUpdate();
        }
    }
}


