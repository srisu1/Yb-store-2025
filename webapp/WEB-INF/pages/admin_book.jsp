<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page import="com.bookstore.dao.BookDAO, com.bookstore.model.Book, java.util.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
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
			
			        <div class="form-group" id="Categories">
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
			        
			        <div class="form-group">
					    <label for="authorSelect">Select Authors:</label>
					    <select id="authorSelect" name="authorIds" multiple="multiple" class="form-control select2">
					        <c:forEach var="author" items="${authors}">
					            <c:set var="isSelected" value="false" />
					            <c:if test="${book.authors != null}">
					                <c:forEach var="aut" items="${book.authors}">
					                    <c:if test="${aut.authorId == author.authorId}">
					                        <c:set var="isSelected" value="true" />
					                    </c:if>
					                </c:forEach>
					            </c:if>
					            <option value="${author.authorId}" <c:if test="${isSelected}">selected</c:if>>
					                ${author.name}
					            </option>
					        </c:forEach>
					    </select>
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
			        <div class="form-group">
					    <label for="authorSelect">Select Authors:</label>
					    <select id="authorSelect" name="authorIds" multiple="multiple" class="form-control select2">
					        <c:forEach var="author" items="${authors}">
					            <option value="${author.authorId}">${author.name}</option>
					        </c:forEach>
					    </select>
					</div>
			        
			
			        <button type="submit">Add Book</button>
			    </form>
			</c:if>
			
			
			<%-- Search Form --%>
			
			<form action="AdminBookServlet" method="get" class="search-form">
			    <input type="text" name="search" placeholder="Search by ID, Title or ISBN" 
			           value="${param.search}">
			    <button type="submit">Search</button>
			    <c:if test="${not empty param.search}">
			        <a href="AdminBookServlet" class="clear-search">Clear Search</a>
			    </c:if>
			</form>

            

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
            <%-- Pagination --%>
			<div class="pagination">
			    <c:if test="${currentPage > 1}">
			        <a href="AdminBookServlet?page=${currentPage - 1}&size=${pageSize}&search=${param.search}">Previous</a>
			    </c:if>
			
			    <c:forEach begin="1" end="${totalPages}" var="i">
			        <c:choose>
			            <c:when test="${currentPage eq i}">
			                <span class="current-page">${i}</span>
			            </c:when>
			            <c:otherwise>
			                <a href="AdminBookServlet?page=${i}&size=${pageSize}&search=${param.search}">${i}</a>
			            </c:otherwise>
			        </c:choose>
			    </c:forEach>
			
			    <c:if test="${currentPage lt totalPages}">
			        <a href="AdminBookServlet?page=${currentPage + 1}&size=${pageSize}&search=${param.search}">Next</a>
			    </c:if>
			</div>
			
			<%-- Items per page selector --%>
			<div class="page-size">
			    <form action="AdminBookServlet" method="get">
			        <input type="hidden" name="search" value="${param.search}">
			        Items per page: 
			        <select name="size" onchange="this.form.submit()">
			            <option value="5" ${pageSize == 5 ? 'selected' : ''}>5</option>
			            <option value="10" ${pageSize == 10 ? 'selected' : ''}>10</option>
			            <option value="20" ${pageSize == 20 ? 'selected' : ''}>20</option>
			        </select>
			    </form>
			</div>

</body>
</html>