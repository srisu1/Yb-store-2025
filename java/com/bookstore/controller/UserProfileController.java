package com.bookstore.controller;

import com.bookstore.dao.AddressDAO;
import com.bookstore.dao.UserAddressPreferenceDAO;
import com.bookstore.dao.UserDAO;
import com.bookstore.model.Address;
import com.bookstore.model.User;
import com.bookstore.model.UserAddressPreference;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/redirectToUserProfile")
public class UserProfileController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private UserDAO userDAO;
    private AddressDAO addressDAO;
    private UserAddressPreferenceDAO preferenceDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
        addressDAO = new AddressDAO();
        preferenceDAO = new UserAddressPreferenceDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        
        if (session == null || session.getAttribute("user") == null) {
            request.setAttribute("showLogin", "true");
            request.getRequestDispatcher("/WEB-INF/pages/home.jsp").forward(request, response);
            return;
        }

        try {
            User sessionUser = (User) session.getAttribute("user");
            
            // Refresh the user data
            User dbUser = userDAO.getUserByEmail(sessionUser.getEmail());
            if (dbUser == null) {
                throw new SQLException("User not found in database");
            }

            // Get address data
            List<Address> addresses = addressDAO.getUserAddresses(dbUser.getUserId());
            UserAddressPreference preferences = preferenceDAO.getPreferences(dbUser.getUserId());

            // Update session and request attributes
            session.setAttribute("user", dbUser);
            request.setAttribute("user", dbUser);
            request.setAttribute("addresses", addresses);
            request.setAttribute("addressPreferences", preferences);

            request.getRequestDispatcher("/WEB-INF/pages/UserProfile.jsp").forward(request, response);

        } catch (SQLException e) {
            request.setAttribute("errorMessage", "Error loading profile data: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/pages/Error.jsp").forward(request, response);
        }
    }
}