package com.bookstore.util;

import java.util.regex.Pattern;

public class ValidationUtil {

    // Validates that name is not empty and contains only letters and spaces
    public static boolean isValidName(String name) {
        return name != null && !name.trim().isEmpty() && name.matches("^[a-zA-Z\\s]+$");
    }

    // Validates that email is not empty and matches a basic email pattern
    public static boolean isValidEmail(String email) {
        return email != null && !email.trim().isEmpty() &&
               Pattern.matches("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$", email);
    }
    
    public static boolean isValidPhone(String phone) {
        if (phone == null) return false;
        return phone.matches("^[+]?[(]?\\d{3}[)]?[-\\s.]?\\d{3}[-\\s.]?\\d{4,6}$");
    }

    // Validates password complexity and match
    public static boolean isValidPassword(String password, String retypePassword) {
        return password != null 
            && retypePassword != null 
            && password.equals(retypePassword)
            && password.length() >= 6
            && (password.matches(".*\\d.*") || password.matches(".*[!@#$%^&*].*"));
    }

    // Checks if any field is empty
    public static boolean isNotEmpty(String input) {
        return input != null && !input.trim().isEmpty();
    }
}
