package com.bookstore.controller;

import com.bookstore.dao.BookDAO;
import com.bookstore.dao.CategoryDAO; 
import com.bookstore.dao.AuthorDAO;
import com.bookstore.util.ImageUtil;
import com.bookstore.model.Book;
import com.bookstore.model.Author;
import com.bookstore.model.Category;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.sql.Date;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/AdminBookServlet")
@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 1024 * 1024 * 5) // size= up to 5MB
public class AdminBookServlet extends HttpServlet {
    private BookDAO bookDAO;
    private AuthorDAO authorDAO;
    private CategoryDAO categoryDAO;

    @Override
    public void init() {
        bookDAO = new BookDAO();
        authorDAO = new AuthorDAO();
        categoryDAO = new CategoryDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String action = request.getParameter("action");
            String searchQuery = request.getParameter("search");
            
            // Pagination parameters
            int page = 1;
            int size = 10;
            
            if (request.getParameter("page") != null) {
                page = Integer.parseInt(request.getParameter("page"));
            }
            if (request.getParameter("size") != null) {
                size = Integer.parseInt(request.getParameter("size"));
            }

            if ("edit".equals(action)) {
                // Edit book handling
                int bookId = Integer.parseInt(request.getParameter("bookId"));
                Book book = bookDAO.getBookById(bookId);
                List<Author> authors = authorDAO.getAllAuthors();
                List<Category> categories = categoryDAO.getAllCategories();

                request.setAttribute("book", book);
                request.setAttribute("authors", authors);
                request.setAttribute("categories", categories);
                request.getRequestDispatcher("/WEB-INF/pages/adminpanel.jsp").forward(request, response);
            } else {
                // Main listing with pagination and search
                List<Book> books;
                int totalBooks;
                
                if (searchQuery != null && !searchQuery.isEmpty()) {
                    // Search mode
                    books = bookDAO.searchBooks(searchQuery, page, size);
                    totalBooks = bookDAO.getSearchCount(searchQuery);
                } else {
                    // Normal paginated mode
                    books = bookDAO.getPaginatedBooks(page, size);
                    totalBooks = bookDAO.getTotalBookCount();
                }

                int totalPages = (int) Math.ceil((double) totalBooks / size);

                List<Author> authors = authorDAO.getAllAuthors();
                List<Category> categories = categoryDAO.getAllCategories();

                request.setAttribute("books", books);
                request.setAttribute("authors", authors);
                request.setAttribute("categories", categories);
                request.setAttribute("currentPage", page);
                request.setAttribute("totalPages", totalPages);
                request.setAttribute("pageSize", size);
                request.setAttribute("searchQuery", searchQuery);

                request.getRequestDispatcher("/WEB-INF/pages/adminpanel.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Failed to load books: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/pages/adminpanel.jsp").forward(request, response);
        }
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            String action = request.getParameter("action");

            if (action == null) {
                request.getSession().setAttribute("error", "No action specified.");
            } else if (action.equals("delete")) {
                int bookId = Integer.parseInt(request.getParameter("bookId"));
                bookDAO.deleteBook(bookId);
                request.getSession().setAttribute("message", "Book deleted successfully.");
            } else {
                Book book = new Book();

                if (action.equals("update")) {
                    book.setBookId(Integer.parseInt(request.getParameter("bookId")));
                }

                book.setTitle(request.getParameter("title"));
                book.setDescription(request.getParameter("description"));
                book.setIsbn(request.getParameter("isbn"));
                book.setPrice(Double.parseDouble(request.getParameter("price")));
                book.setStockQuantity(Integer.parseInt(request.getParameter("stockQuantity")));
                book.setPublicationDate(new java.util.Date(
                        Date.valueOf(request.getParameter("publicationDate")).getTime()));

                Part imagePart = request.getPart("coverImage");
                if (imagePart != null && imagePart.getSize() > 0) {
                    // Creating an instance of ImageUtil to handle image saving
                    ImageUtil imageUtil = new ImageUtil();
                    
                    // Getting the absolute upload path within the server's file system
                    String uploadPath = getServletContext().getRealPath("/resources/uploads");
                    
                    // Ensuring the upload directory exists
                    File uploadDir = new File(uploadPath);
                    if (!uploadDir.exists()) {
                        boolean created = uploadDir.mkdirs();  // Create the directory if it doesn't exist
                        if (created) {
                            System.out.println("Uploads directory created: " + uploadPath);
                        } else {
                            System.out.println("Failed to create uploads directory.");
                        }
                    }

                    // Debugging: printing the upload path and check the file size
                    System.out.println("Upload path: " + uploadPath);
                    System.out.println("Image size: " + imagePart.getSize());

                    // Saving the image to disk and get the file name
                    String fileName = imageUtil.saveToDisk(imagePart, uploadPath);
                    if (fileName != null) {
                        // Storing the relative path (without duplicating '/resources/uploads')
                        book.setCoverImageUrl("/resources/uploads/" + fileName);  

                        // Debugging: Confirm the file name and URL being saved
                        System.out.println("File saved with name: " + fileName);
                        System.out.println("Cover Image URL: " + book.getCoverImageUrl());
                    } else {
                        // Handling error in saving the file
                        System.out.println("Failed to save image to disk.");
                    }
                } else {
                    // Fallback: if no image is uploaded, retain the existing image URL if there is any
                    book.setCoverImageUrl(request.getParameter("coverImageUrl"));
                }


                
                
                


                // --- Handle category and author IDs ---
                String[] categoryIdsParam = request.getParameterValues("categoryIds");
                List<Integer> categoryIds = categoryIdsParam != null
                        ? Arrays.stream(categoryIdsParam).map(Integer::parseInt).collect(Collectors.toList())
                        : new ArrayList<>();

                String[] authorIdsParam = request.getParameterValues("authorIds");
                List<Integer> authorIds = authorIdsParam != null
                        ? Arrays.stream(authorIdsParam).map(Integer::parseInt).collect(Collectors.toList())
                        : new ArrayList<>();

                if (action.equals("add")) {
                    bookDAO.addBook(book, authorIds, categoryIds);
                    request.getSession().setAttribute("message", "Book added successfully.");
                } else if (action.equals("update")) {
                    bookDAO.updateBook(book, authorIds, categoryIds);
                    request.getSession().setAttribute("message", "Book updated successfully.");
                }
            }

        } catch (Exception e) {
            request.getSession().setAttribute("error", "Error: " + e.getMessage());
            e.printStackTrace();
        }

        response.sendRedirect("AdminBookServlet");
    }
}
