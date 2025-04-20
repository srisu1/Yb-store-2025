package com.bookstore.controller;

import com.bookstore.model.User;
import com.bookstore.util.PasswordUtil;
import com.bookstore.util.ValidationUtil;
import com.bookstore.dao.UserDAO;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/register")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,  // 2MB
    maxFileSize = 1024L * 1024L * 10L,    // 10MB
    maxRequestSize = 1024L * 1024L * 50L  // 50MB
)
public class RegistrationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	
    	request.getRequestDispatcher("/WEB-INF/pages/home.jsp").forward(request, response);

    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        System.out.println("[DEBUG] Registration attempt started");

        // Get all parameters first
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String phoneNumber = request.getParameter("phoneNumber");
        String address = request.getParameter("address");
        String language = request.getParameter("language");

        UserDAO userDAO = new UserDAO();

        // 1. Validate name
        if (!ValidationUtil.isValidName(fullName)) {
            request.setAttribute("error", "Invalid name format (letters and spaces only)");
            request.setAttribute("triggerRegister", true);
            request.getRequestDispatcher("/WEB-INF/pages/home.jsp").forward(request, response);
            return;
        }

        // 2. Validate email format
        if (!ValidationUtil.isValidEmail(email)) {
            request.setAttribute("error", "Invalid email format");
            request.setAttribute("triggerRegister", true);
            request.getRequestDispatcher("/WEB-INF/pages/home.jsp").forward(request, response);
            return;
        }

        // 3. Check if email already exists (MOVED THIS UP)
        if (userDAO.isEmailExists(email)) {
            request.setAttribute("errorMessage", "An account with this email already exists. Please log in.");
            request.setAttribute("triggerLogin", true);
            request.getRequestDispatcher("/WEB-INF/pages/home.jsp").forward(request, response);
            return;
        }

        // 4. Password validation
        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match");
            request.setAttribute("triggerRegister", true);
            request.getRequestDispatcher("/WEB-INF/pages/home.jsp").forward(request, response);
            return;
        }
        
        if (!ValidationUtil.isValidPassword(password, confirmPassword)) {
            request.setAttribute("error", "Password needs 6+ chars with number/special character");
            request.setAttribute("triggerRegister", true);
            request.getRequestDispatcher("/WEB-INF/pages/home.jsp").forward(request, response);
            return;
        }

        // 5. Phone validation
        if (phoneNumber != null && !phoneNumber.isBlank()) {
            if (!ValidationUtil.isValidPhone(phoneNumber)) {
                request.setAttribute("error", "Invalid phone format");
                request.setAttribute("triggerRegister", true);
                request.getRequestDispatcher("/WEB-INF/pages/home.jsp").forward(request, response);
                return;
            }
            if (userDAO.isPhoneNumberExists(phoneNumber)) {
                request.setAttribute("error", "Phone number already exists");
                request.setAttribute("triggerRegister", true);
                request.getRequestDispatcher("/WEB-INF/pages/home.jsp").forward(request, response);
                return;
            }
        }

        // CREATE USER OBJECT AFTER ALL VALIDATIONS
        String passwordHash = PasswordUtil.hashPassword(password);
        String now = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
        
        User newUser = new User(
            0,
            fullName,
            email,
            passwordHash,
            (address != null && !address.isBlank()) ? address : null,
            (phoneNumber != null && !phoneNumber.isBlank()) ? phoneNumber : null,
            (language != null && !language.isBlank()) ? language : null,
            "customer",
            null,
            0,
            now,
            now
        );

        System.out.println("[DEBUG] Attempting to create user: " + email);
        
        // ADD USER TO DATABASE
        boolean success = userDAO.addUser(newUser);
        System.out.println("[DEBUG] User creation " + (success ? "successful" : "failed"));

        // HANDLE RESULT
        if (success) {
            request.setAttribute("triggerLogin", true);
            request.setAttribute("info", "Registration successful! Please login.");
        } else {
            request.setAttribute("error", "Registration failed. Please try again.");
            request.setAttribute("triggerRegister", true);
        }

        request.getRequestDispatcher("/WEB-INF/pages/home.jsp").forward(request, response);
    }

        
       
        
    }