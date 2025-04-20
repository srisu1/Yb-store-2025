package com.bookstore.util;

import org.mindrot.jbcrypt.BCrypt;

public class PasswordUtil {

    // Hash the password (use this during registration)
    public static String hashPassword(String plainTextPassword) {
        return BCrypt.hashpw(plainTextPassword, BCrypt.gensalt(12)); // 12 is the work factor
    }

    // Verify password during login
    public static boolean checkPassword(String plainTextPassword, String hashedPassword) {
        if (hashedPassword == null || !hashedPassword.startsWith("$2a$")) {
            throw new IllegalArgumentException("Invalid hash provided for comparison");
        }
        return BCrypt.checkpw(plainTextPassword, hashedPassword);
    }
}