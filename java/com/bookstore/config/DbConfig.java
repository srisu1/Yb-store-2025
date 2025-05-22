package com.bookstore.config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

//DbConfig is a configuration class for managing database connection. It handles connection to mysql using JDBC

public class DbConfig {
	
	//Database configuration info
	private static final String DB_NAME="yonder_bookstore";
	private static final String URL = "jdbc:mysql://localhost:3306/"+DB_NAME;
    private static final String USER = "root";
    private static final String PASS = "";
    
    
//    Establishes a connection to the database.
//    @return Connection object for the database
//    @throws SQLException  if database access error occurs
//    @throws ClassNotFoundException if theJDBC driver class is not found
    
    
    static {
        try {
            // Load driver once at class loading
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("MySQL JDBC Driver not found", e);
        }
    }

    public static Connection getDbConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASS);
    }

}
