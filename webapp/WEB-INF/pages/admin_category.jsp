<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<h2>Manage Categories</h2>

<!-- Category List -->
<table border="1" cellpadding="8" cellspacing="0" style="width: 50%; margin-bottom: 20px;">
    <thead>
        <tr>
            <th>ID</th>
            <th>Category Name</th>
            <th>Actions</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="category" items="${categories}">
            <tr>
                <td>${category.categoryId}</td>
                <td>${category.categoryName}</td>
               <td>
				    <a href="CategoryServlet?action=edit&id=${category.categoryId}" class="table-action-button">Edit</a>
				    <a href="CategoryServlet?action=delete&id=${category.categoryId}" 
				       onclick="return confirm('Are you sure you want to delete this category?');"
				       class="table-action-button delete-button">Delete</a>
				</td>

            </tr>
        </c:forEach>
    </tbody>
</table>

<!-- Add / Update Category Form -->
<c:choose>
    <c:when test="${not empty category}">
        <h3>Edit Category</h3>
        <form action="CategoryServlet" method="post">
            <input type="hidden" name="action" value="update" />
            <input type="hidden" name="categoryId" value="${category.categoryId}" />

            <label for="categoryName">Category Name:</label>
            <input type="text" id="categoryName" name="categoryName" value="${category.categoryName}" required />
            <button type="submit">Update Category</button>
            <a href="CategoryServlet">Cancel</a>
        </form>
    </c:when>
    <c:otherwise>
        <h3>Add New Category</h3>
        <form action="CategoryServlet" method="post" style="background: #f4efe3;">
            <input type="hidden" name="action" value="add" />
            <label for="categoryName">Category Name:</label>
            <input type="text" id="categoryName" name="categoryName" required />
            <button type="submit">Add Category</button>
        </form>
    </c:otherwise>
</c:choose>
