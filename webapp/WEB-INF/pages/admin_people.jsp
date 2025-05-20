<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="com.bookstore.model.Author, com.bookstore.model.User, com.bookstore.dao.UserDAO,com.bookstore.dao.AuthorDAO,java.util.List" %>
<%
    UserDAO userDAO = new UserDAO();
    List<User> users = userDAO.getAllUsers();
    request.setAttribute("users", users);
    
    AuthorDAO authorDAO = new AuthorDAO();
    List<Author> authors = authorDAO.getAllAuthors();
    request.setAttribute("authors", authors);
    
    
%>

<div class="people-section author-section" style="padding: 2em;">
    <h2>People Management</h2>
    <div class="toggle-buttons">
	    <button class="toggle-btn active" onclick="togglePeopleSection('author')">Manage Authors</button>
	    <button class="toggle-btn" onclick="togglePeopleSection('user')">Manage Users</button>
	</div>
    

    <!-- Manage Authors -->
    <div id="author-management" class="people-subsection">
        <h3>${author != null ? "Edit Author" : "Add Author"}</h3>

        <form action="AdminAuthorServlet" method="post">
            <input type="hidden" name="action" value="${author != null ? 'update' : 'add'}" />
            <c:if test="${author != null}">
                <input type="hidden" name="authorId" value="${author.authorId}" />
            </c:if>

            <div class="form-group">
                <label for="authorName">Name:</label>
                <input type="text" name="name" id="authorName" value="${author != null ? author.name : ''}" required />
            </div>

            <div class="form-group">
                <label for="authorBio">Bio:</label>
                <textarea name="bio" id="authorBio">${author != null ? author.bio : ''}</textarea>
            </div>

            <div class="form-group">
                <label for="authorEmail">Email:</label>
                <input type="email" name="email" id="authorEmail" value="${author != null ? author.email : ''}" required />
            </div>

            <button type="submit">${author != null ? "Update Author" : "Add Author"}</button>
        </form>

        <h4>Existing Authors</h4>
        <table>
            <tr>
                <th>Name</th>
                <th>Bio</th>
                <th>Email</th>
                <th>Action</th>
            </tr>
            <c:forEach items="${authors}" var="author">
                <tr>
                    <td>${author.name}</td>
                    <td>${author.bio}</td>
                    <td>${author.email}</td>
                    <td>
                        <a href="AdminAuthorServlet?action=edit&id=${author.authorId}">Edit</a>
                        |
                        <a href="AdminAuthorServlet?action=delete&id=${author.authorId}">Delete</a>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </div>

    <!-- Manage Users -->
    <div id="user-management" class="people-subsection">
        <h3>Manage Users</h3>
        <table>
            <tr>
                <th>Name</th>
                <th>Email</th>
                <th>Role</th>
                <th>Action</th>
            </tr>
            <c:forEach items="${users}" var="user">
                <tr>
                    <td>${user.fullName}</td>
                    <td>${user.email}</td>
                    <td>
                        <form action="AdminUserServlet" method="post">
						    <input type="hidden" name="userId" value="${user.userId}" />
						    <input type="hidden" name="action" value="updateRole" />
						    <select name="role" onchange="this.form.submit()">
						        <option value="customer" <c:if test="${user.role == 'customer'}">selected</c:if>>Customer</option>
						        <option value="admin" <c:if test="${user.role == 'admin'}">selected</c:if>>Admin</option>
						    </select>
						</form>
                    </td>
                    <td>
                        <form action="AdminUserServlet" method="post">
                            <input type="hidden" name="action" value="delete" />
                            <input type="hidden" name="userId" value="${user.userId}" />
                            <button type="submit">Delete</button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </div>
</div>

