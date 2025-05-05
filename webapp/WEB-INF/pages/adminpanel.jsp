<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page import="com.bookstore.dao.BookDAO, com.bookstore.model.Book, java.util.*"%>

<!DOCTYPE html>
<html>
<head>
    <title>Book Admin Panel</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; background: #f0f0f0; }
        .container { max-width: 1200px; margin: 0 auto; }
        .admin-panel { background: white; padding: 20px; border-radius: 8px; box-shadow: 0 0 10px rgba(0,0,0,0.1); }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { padding: 12px; text-align: left; border-bottom: 1px solid #ddd; }
        th { background: #4CAF50; color: white; }
        tr:hover { background: #f5f5f5; }
        .form-group { margin-bottom: 15px; }
        input[type="text"], input[type="number"], input[type="date"], textarea {
            width: 100%; padding: 8px; border: 1px solid #ddd; border-radius: 4px;
        }
        button { 
            background: #4CAF50; color: white; border: none; padding: 10px 20px;
            border-radius: 4px; cursor: pointer; 
        }
        button:hover { background: #45a049; }
        .message { padding: 10px; margin: 10px 0; border-radius: 4px; }
        .success { background: #dff0d8; color: #3c763d; }
        .error { background: #f2dede; color: #a94442; }
    </style>
</head>
<body>
    <div class="container">
        <div class="admin-panel">
            <h1>Book Administration</h1>
            
            <%-- Display messages --%>
            <c:if test="${not empty message}">
                <div class="message success">${message}</div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="message error">${error}</div>
            </c:if>

            <%-- Add/Edit Form --%>
            <%-- Only show form to edit a book if `book` is not empty --%>
            
            
			<c:if test="${not empty book}">
			    <form action="AdminBookServlet" method="post" enctype="multipart/form-data">
			    	 
			        <input type="hidden" name="action" value="update" />
			        <input type="hidden" name="bookId" value="${book.bookId}" />
			
			        <div class="form-group">
			            <label>Title:</label>
			            <input type="text" name="title" value="${book.title}" required />
			        </div>
			
			          <div class="form-group">
				        <label>Cover Image URL:</label>
				        <input type="text" name="coverImageUrl" value="${book.coverImageUrl}" />
				    </div>
				    <div class="form-group">
				        <label>Or Upload Cover Image:</label>
				        <input type="file" name="coverImage" accept="image/*" style="border: 2px solid red;" />

				    </div>
				
				   
			
			        <div class="form-group">
			            <label>Price:</label>
			            <input type="number" step="0.01" name="price" value="${book.price}" required />
			        </div>
			
			        <div class="form-group">
			            <label>Description:</label>
			            <textarea name="description">${book.description}</textarea>
			        </div>
			
			        <div class="form-group">
			            <label>ISBN:</label>
			            <input type="text" name="isbn" value="${book.isbn}" required />
			        </div>
			
			        <div class="form-group">
			            <label>Publication Date:</label>
			            <input type="date" name="publicationDate" 
			                   value="<fmt:formatDate value='${book.publicationDate}' pattern='yyyy-MM-dd' />" />
			        </div>
			
			        <div class="form-group">
			            <label>Stock Quantity:</label>
			            <input type="number" name="stockQuantity" value="${book.stockQuantity}" required />
			        </div>
			
			        <div class="form-group">
			            <label>Select Categories:</label><br>
			            <c:forEach var="category" items="${categories}">
			                <c:set var="isChecked" value="false" />
			                <c:if test="${book.categories != null}">
			                    <c:forEach var="cat" items="${book.categories}">
			                        <c:if test="${cat.categoryId == category.categoryId}">
			                            <c:set var="isChecked" value="true" />
			                        </c:if>
			                    </c:forEach>
			                </c:if>
			
			                <label>
			                    <input type="checkbox" name="categoryIds" value="${category.categoryId}"
			                           <c:if test="${isChecked}">checked</c:if> />
			                    ${category.categoryName}
			                </label><br>
			            </c:forEach>
			        </div>
			
			        <button type="submit">Update Book</button>
			    </form>
			</c:if>
			
			<%-- Show Add Book form if `book` is empty or not being edited --%>
			<c:if test="${empty book}">
			    <form action="AdminBookServlet" method="post" enctype="multipart/form-data">
			        <input type="hidden" name="action" value="add" />
			
			        <div class="form-group">
			            <label>Title:</label>
			            <input type="text" name="title" required />
			        </div>
			
			        <div class="form-group">
			            <label>Cover Image URL:</label>
			            <input type="text" name="coverImageUrl" />
			        </div>
			        <div class="form-group">
				        <label>Or Upload Cover Image:</label>
				        <input type="file" name="coverImage" accept="image/*"  />

				    </div>
			
			        <div class="form-group">
			            <label>Price:</label>
			            <input type="number" step="0.01" name="price" required />
			        </div>
			
			        <div class="form-group">
			            <label>Description:</label>
			            <textarea name="description"></textarea>
			        </div>
			
			        <div class="form-group">
			            <label>ISBN:</label>
			            <input type="text" name="isbn" required />
			        </div>
			
			        <div class="form-group">
			            <label>Publication Date:</label>
			            <input type="date" name="publicationDate" />
			        </div>
			
			        <div class="form-group">
			            <label>Stock Quantity:</label>
			            <input type="number" name="stockQuantity" required />
			        </div>
			
			        <div class="form-group">
			            <label>Select Categories:</label><br>
			            <c:forEach var="category" items="${categories}">
			                <label>
			                    <input type="checkbox" name="categoryIds" value="${category.categoryId}" />
			                    ${category.categoryName}
			                </label><br>
			            </c:forEach>
			        </div>
			
			        <button type="submit">Add Book</button>
			    </form>
			</c:if>

            

            <%-- Books List --%>
            <table>
                <tr>
                    <th>ID</th>
                    <th>Title</th>
                    <th>Price</th>
                    <th>ISBN</th>
                    <th>Stock</th>
                    <th>Cover</th>
                    <th>Actions</th>
                </tr>
                <c:forEach items="${books}" var="book">
                    <tr>
                        <td>${book.bookId}</td>
                        <td>${book.title}</td>
                        <td>$${book.price}</td>
                        <td>${book.isbn}</td>
                        <td>${book.stockQuantity}</td>
                        <td><img src="<c:url value='${book.coverImageUrl}' />" alt="Book Cover" /></td>
                        <td>
                            <form action="AdminBookServlet" method="post" style="display:inline;">
							    <input type="hidden" name="action" value="delete" />
							    <input type="hidden" name="bookId" value="${book.bookId}" />
							    <button type="submit" onclick="return confirm('Are you sure?')">Delete</button>
							</form>
							<form action="AdminBookServlet" method="get" style="display:inline;">
							    <input type="hidden" name="action" value="edit" />
							    <input type="hidden" name="bookId" value="${book.bookId}" />
							    <button type="submit">Edit</button>
							</form>

					

                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty books}">
                    <tr><td colspan="7">No books found.</td></tr>
                </c:if>
            </table>
        </div>
    </div>
</body>
</html>