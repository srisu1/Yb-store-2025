package com.bookstore.controller;

import com.bookstore.config.DbConfig;
import com.bookstore.dao.BookDAO;
import com.bookstore.dao.CategoryDAO;
import com.bookstore.dao.AuthorDAO;
import com.bookstore.model.Book;
import com.bookstore.model.Category;
import com.bookstore.model.Author;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/catalog")
public class CatalogueController extends HttpServlet {
    
    private final CategoryDAO categoryDao = new CategoryDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        String categoryId = request.getParameter("categoryId");
        String sortBy = request.getParameter("sortBy");
        String authorName = request.getParameter("authorName");
        String minPriceStr = request.getParameter("minPrice");
        String maxPriceStr = request.getParameter("maxPrice");

        // Pagination params for default "all books" view
        String pageStr = request.getParameter("page");
        String pageSizeStr = request.getParameter("pageSize");

        int page = 1;
        int pageSize = 10; // default page size

        try {
            if (pageStr != null) page = Integer.parseInt(pageStr);
            if (pageSizeStr != null) pageSize = Integer.parseInt(pageSizeStr);
        } catch (NumberFormatException e) {
            // ignore and keep defaults if parsing fails
        }

        Connection connection = null;

        try {
            connection = DbConfig.getDbConnection();

            BookDAO bookDAO = new BookDAO();
            AuthorDAO authorDAO = new AuthorDAO();

            // Books of the week (used in all views)
            List<Book> booksOfWeek = bookDAO.getBooksOfTheWeek();
            request.setAttribute("booksOfWeek", booksOfWeek);

            // Categories and authors for filters
            List<Category> categories = categoryDao.getAllCategories();
            request.setAttribute("categories", categories);

            List<Author> authors = authorDAO.getAllAuthors();
            request.setAttribute("authors", authors);

            List<Book> books;

            // Author filter has highest priority
            if (authorName != null && !authorName.trim().isEmpty()) {
                books = bookDAO.getBooksByAuthorName(connection, authorName.trim());
            } 
            // Price filter next priority (if both minPrice and maxPrice are valid)
            else if (minPriceStr != null && maxPriceStr != null && !minPriceStr.isEmpty() && !maxPriceStr.isEmpty()) {
                try {
                    double minPrice = Double.parseDouble(minPriceStr);
                    double maxPrice = Double.parseDouble(maxPriceStr);

                    // Swap if min > max to avoid logic error
                    if (minPrice > maxPrice) {
                        double temp = minPrice;
                        minPrice = maxPrice;
                        maxPrice = temp;
                    }

                    books = bookDAO.getBooksByPriceRange(minPrice, maxPrice);

                } catch (NumberFormatException e) {
                    // If parsing fails, fallback to all books
                    books = bookDAO.getAllBooksWithAuthors();
                }
            } 
            // Sorting filter
            else if (sortBy != null && !sortBy.isEmpty()) {
                switch (sortBy) {
                    case "low-to-high":
                        books = bookDAO.getBooksSortedByPrice(connection, true);
                        break;
                    case "high-to-low":
                        books = bookDAO.getBooksSortedByPrice(connection, false);
                        break;
                    case "newest":
                        books = bookDAO.getNewArrivals();
                        break;
                    case "bestseller":
                        books = bookDAO.getBestSellers();
                        break;
                    case "books-of-the-week":
                        books = bookDAO.getBooksOfTheWeek();
                        break;
                    default:
                        books = bookDAO.getAllBooksWithAuthors();
                        break;
                }
            } 
            // Category filter
            else if (categoryId != null && !categoryId.isEmpty()) {
                books = bookDAO.getBooksByCategory(connection, categoryId);
            } 
            // Default: paginate all books
            else {
                int offset = (page - 1) * pageSize;
                books = bookDAO.getBooksWithAuthorsPaginated(offset, pageSize);

                // Also get total count for pagination UI
                int totalBooks = bookDAO.getTotalBooksCount();
                int totalPages = (int) Math.ceil((double) totalBooks / pageSize);

                request.setAttribute("currentPage", page);
                request.setAttribute("pageSize", pageSize);
                request.setAttribute("totalPages", totalPages);
                request.setAttribute("totalBooks", totalBooks);
            }

            request.setAttribute("books", books);
            request.getRequestDispatcher("/WEB-INF/pages/catalog.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error loading catalog");
        } finally {
            if (connection != null) {
                try { connection.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        }
    }
}
