package com.bookstore.controller;

import com.bookstore.model.Cart;
import com.bookstore.model.CartItem;
import com.bookstore.model.User;
import com.bookstore.dao.CartDAO;
import com.bookstore.config.DbConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	System.out.println("CartServlet doPost called");
        String action = request.getParameter("action");
        System.out.println("Action: " + action);
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        System.out.println("User from session: " + user);


        if (user == null) {
            // Not logged in, redirect to login page
            response.sendRedirect("login.jsp");
            return;
        }

        CartDAO cartDAO;
        Cart cart = (Cart) session.getAttribute("cart");

        try {
            // Get DB connection inside try block to handle SQLException
            cartDAO = new CartDAO(DbConfig.getDbConnection());

            if (cart == null) {
                cart = cartDAO.getCartByUserId(user.getUserId());
                if (cart == null) {
                    int newCartId = cartDAO.createCartForUser(user.getUserId());
                    cart = new Cart();
                    cart.setCartId(newCartId);
                    cart.setUserId(user.getUserId());
                    cart.setItems(new ArrayList<>());
                }
                session.setAttribute("cart", cart);
            }

            switch (action) {
                case "add":
                    int bookId = Integer.parseInt(request.getParameter("bookId"));
                    int quantity = Integer.parseInt(request.getParameter("quantity"));
                    cartDAO.addOrUpdateCartItem(cart.getCartId(), bookId, quantity);

                    // Also update session cart
                    addToCart(request, cart);
                    break;

                case "remove":
                    bookId = Integer.parseInt(request.getParameter("bookId"));
                    cartDAO.removeCartItem(cart.getCartId(), bookId);
                    removeFromCart(request, cart);
                    break;

                case "update":
                    bookId = Integer.parseInt(request.getParameter("bookId"));
                    quantity = Integer.parseInt(request.getParameter("quantity"));
                    cartDAO.updateCartItemQuantity(cart.getCartId(), bookId, quantity);
                    updateQuantity(request, cart);
                    break;
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }

        String referer = request.getHeader("referer");
        if (referer == null || referer.isEmpty()) {
            referer = request.getContextPath() + "/bookdetails.jsp?bookId=" + request.getParameter("bookId");
        }
        response.sendRedirect(referer);
    }


       

    private void addToCart(HttpServletRequest request, Cart cart) {
        int bookId = Integer.parseInt(request.getParameter("bookId"));
        String title = request.getParameter("title");
        String cover = request.getParameter("cover");
        double price = Double.parseDouble(request.getParameter("price"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        // Check if already in cart
        for (CartItem item : cart.getItems()) {
            if (item.getBookId() == bookId) {
                item.setQuantity(item.getQuantity() + quantity);
                return;
            }
        }

        // Not in cart, add new
        CartItem item = new CartItem();
        item.setBookId(bookId);
        item.setBookTitle(title);
        item.setBookCoverUrl(cover);
        item.setPrice(price);
        item.setQuantity(quantity);
        cart.getItems().add(item);
    }

    private void removeFromCart(HttpServletRequest request, Cart cart) {
        int bookId = Integer.parseInt(request.getParameter("bookId"));
        cart.getItems().removeIf(item -> item.getBookId() == bookId);
    }

    private void updateQuantity(HttpServletRequest request, Cart cart) {
        int bookId = Integer.parseInt(request.getParameter("bookId"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        for (CartItem item : cart.getItems()) {
            if (item.getBookId() == bookId) {
                item.setQuantity(quantity);
                break;
            }
        }
    }
}
