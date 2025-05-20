<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.bookstore.model.Cart" %>
<%@ page import="com.bookstore.model.CartItem" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.bookstore.dao.BookDAO" %>
<%@ page import="com.bookstore.model.Book" %>

<%
    BookDAO bookDAO = new BookDAO();  // create DAO object
    String query = request.getParameter("query");
    List<Book> searchResults = null;

    if (query != null && !query.trim().isEmpty()) {
        searchResults = bookDAO.searchBooks(query.trim(), 1, 50); // get top 50 matches
        request.setAttribute("searchResults", searchResults);
    }
%>



	<!-- The login modal -->
    <div class="modal-overlay" id="loginOverlay">
        <div class="modal-content">
        <span class="close-btn">&times;</span>
        <!-- Login form -->
        <div class="login-form">
            <h2>YOU MUST LOGIN</h2>
            
            <%-- Success message after registration --%>
		    <c:if test="${not empty info}">
		        <div class="alert alert-success">${info}</div>
		    </c:if>
		    <%-- Error message for existing email --%>
		    <c:if test="${not empty errorMessage}">
		        <div class="alert alert-danger">${errorMessage}</div>
		    </c:if>
		    
            <button class="social-login google">
            Continue with Google <i class="fa-brands fa-google"></i>
            </button>
           
            
           <div class="separator">OR</div>
            
            <form action="<%= request.getContextPath() %>/login" method="post">
			    <div class="form-group">
			        <input type="email" name="email" placeholder="EMAIL ADDRESS" required>
			    </div>
			    <div class="form-group">
			        <input type="password" name="password" placeholder="PASSWORD" required>
			    </div>
			    <div class="options">
			        <label><input type="checkbox" name="rememberMe"> REMEMBER ME</label>
			        <a href="#">FORGOT PASSWORD?</a>
			    </div>
			    <button type="submit" class="login-btn">Login</button>
			</form>
            
            <div class="register-link">
            Don't have an account? <a href="#" id="showRegister">REGISTER</a>
            </div>
        </div>
        </div>
    </div>
    
    
    
    <!-- The register modal -->
    <div class="modal-overlay" id="registerOverlay" >
        <div class="modal-content">
        <span class="close-btn">&times;</span>
        <!-- Registration form -->
        <div class="login-form">
            <h2>REGISTER</h2>
            
            <c:if test="${not empty error}">
		        <div class="alert alert-danger">
		            <c:choose>
		                <c:when test="${error == 'invalidPassword'}">
		                    Password must be 6+ characters with at least one letter and one number/special character
		                </c:when>
		                <c:when test="${error == 'phoneExists'}">
		                    Phone number already registered
		                </c:when>
		                <c:otherwise>
		                    ${error}
		                </c:otherwise>
		            </c:choose>
		        </div>
		    </c:if>
		    <!-- Rest of registration form -->
		    
		    
            <button class="social-login google">
            Continue with Google
            </button>
            
            <div class="separator">OR</div>
            
            
            <form action="<%= request.getContextPath() %>/register" method="post">
                <div class="form-group">
                    <input type="text" name="fullName" id="fullName" placeholder="FULL NAME" required>
                </div>
                <div class="form-group">
                    <input type="email" name="email" id="email" placeholder="EMAIL" required>
                </div>
                <div class="form-group">
                    <input type="password" name="password" id="password" placeholder="PASSWORD" required>
                </div>
                <div class="form-group">
                    <input type="password" name="confirmPassword" id="confirmPassword" placeholder="CONFIRM PASSWORD" required>
                </div>
                <div class="form-group">
                    <input type="text" name="phoneNumber" id="phone" placeholder="PHONE NUMBER" required>
                </div>
                <label class="terms">
                    <input type="checkbox" name="termsAccepted" id="termsAccepted" required> By creating an account I accept the Terms and Conditions
                </label>
                <button type="submit" class="login-btn">Register</button>
            </form>
            
            
            <div class="register-link">
            Already have an account? <a href="#" id="showLogin">LOGIN</a>
            </div>
        </div>
        </div>
    </div>
    
    
    
    <!-- search modal -->
     <div class="modal-overlay" id="searchOverlay">
        <div class="modal-content">
        <span class="close-btn">&times;</span>
        <div class="search-form">
            <h2>Search Products</h2>
            <form method="get" action="<%= request.getContextPath() %>/search">
			    <div class="form-group">
			        <input type="text" placeholder="What are you looking for?" id="searchInput" name="query" autofocus value="<c:out value='${param.query}'/>">
			    </div>
			    <button type="submit" class="search-btn">Search</button>
			</form>
			<c:if test="${not empty searchResults}">
			    <ul style="max-height:300px; overflow-y:auto; padding-left:0; list-style:none; margin-top:20px;">
			        <c:forEach var="book" items="${searchResults}">
			            <li style="margin-bottom:10px;">
			                <a href="bookdetails?id=${book.bookId}" style="display:flex; align-items:center; text-decoration:none; color:black;">
			                    <img src="${book.coverImageUrl}" alt="${book.title}" style="width:50px; height:70px; object-fit:cover; margin-right:10px;">
			                    <span>${book.title}</span>
			                </a>
			            </li>
			        </c:forEach>
			    </ul>
			</c:if>

			<c:if test="${empty searchResults && not empty param.query}">
			    <p>No results found for "<strong><c:out value='${param.query}'/></strong>".</p>
			</c:if>
						

        </div>
        </div>
    </div>
    
    
    
   <%
    Cart cart = (Cart) session.getAttribute("cart");
    List<CartItem> items = (cart != null) ? cart.getItems() : new java.util.ArrayList<>();
    request.setAttribute("items", items);
%>

<!-- Cart Modal -->
<div class="modal-overlay" id="cartOverlay">
    <div class="cart-modal">
        <div class="cart-header">
            <h2>Your basket</h2>
            <span class="close-btn">&times;</span>
        </div>

        <div class="cart-items">
            <c:choose>
                <c:when test="${not empty items}">
                    <c:set var="total" value="0" />
                    <c:forEach var="item" items="${items}">
                        <c:set var="itemTotal" value="${item.price * item.quantity}" />
                        <c:set var="total" value="${total + itemTotal}" />

                        <div class="cart-item">
                            <div class="item-info">
                                <label class="item-select">
                                    <input type="checkbox" checked>
                                    <span class="checkmark"></span>
                                </label>
                                <div class="item-details">
                                    <h3 class="item-title">${item.bookTitle}</h3>
                                    <img src="${item.bookCoverUrl}" alt="${item.bookTitle} Cover" />
                                    <p class="item-price">Rs. ${item.price}</p>
                                </div>
                            </div>
                            <div class="item-controls">
                                <div class="quantity-selector">
                                    <form action="cart" method="post" class="quantity-form">
                                        <input type="hidden" name="action" value="update" />
                                        <input type="hidden" name="bookId" value="${item.bookId}" />
                                        <input type="number" name="quantity" value="${item.quantity}" min="1" class="quantity-input" />
                                        <button type="submit" class="quantity-btn">Update</button>
                                    </form>
                                    <form action="cart" method="post" class="remove-form">
                                        <input type="hidden" name="action" value="remove" />
                                        <input type="hidden" name="bookId" value="${item.bookId}" />
                                        <button type="submit" class="remove-btn">Remove</button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <p style="padding: 1rem;">Your cart is empty.</p>
                </c:otherwise>
            </c:choose>
        </div>

        <div class="cart-summary">
            <div class="total-price">
                <span>Total:</span>
                <span class="total-amount">Rs. <c:out value="${total}" /></span>
            </div>
            <form action="checkout" method="post">
                <button class="checkout-btn">BUY</button>
            </form>
        </div>
    </div>
</div>
<script>
document.addEventListener('DOMContentLoaded', function () {
    const cartOverlay = document.getElementById('cartOverlay');
    const closeBtn = cartOverlay.querySelector('.close-btn');

  

    closeBtn.addEventListener('click', function () {
        cartOverlay.style.display = 'none';
        document.body.classList.remove('modal-open');
    });

    cartOverlay.addEventListener('click', function (e) {
        if (e.target === cartOverlay) {
            cartOverlay.style.display = 'none';
            document.body.style.overflow = '';  // re-enable scroll when closed
        }
    });
});

document.addEventListener('DOMContentLoaded', function() {
    const searchOverlay = document.getElementById('searchOverlay');
    const urlParams = new URLSearchParams(window.location.search);
    if (urlParams.has('query')) {
        searchOverlay.style.display = 'flex';
        document.body.classList.add('modal-open'); 
    }
});



</script>