package com.bookstore.controller;
import com.bookstore.dao.*;
import com.bookstore.model.Book;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

/**
 * @author srisukarki
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/home","/" })
public class HomeController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String error = (String) request.getAttribute("error");
        if (error != null) {
            request.setAttribute("error", error);
        }
        
     // Fetch books from DAO
        try {
            BookDAO bookDAO = new BookDAO();
            List<Book> books = bookDAO.getAllBooksWithAuthors(); // 
            request.setAttribute("books", books);
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            request.setAttribute("error", "Unable to load books at the moment.");
        }

        // Forward to JSP
		request.getRequestDispatcher("/WEB-INF/pages/home.jsp").forward(request,response);
		
		
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
	        throws ServletException, IOException {
	    doGet(req,resp);
	}

	

}


