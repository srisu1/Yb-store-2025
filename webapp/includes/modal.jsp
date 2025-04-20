<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
            Continue with Google
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
            <form>
            <div class="form-group">
                <input type="text" placeholder="What are you looking for?" id="searchInput" autofocus>
            </div>
            <button type="submit" class="search-btn">Search</button>
            </form>
        </div>
        </div>
    </div>
    
    
    
    <!-- Cart Modal -->
    <div class="modal-overlay" id="cartOverlay">
        <div class="cart-modal">
        <div class="cart-header">
            <h2>Your Cart</h2>
            <span class="close-btn">&times;</span>
        </div>
        
        <div class="cart-items">
            <!-- Sample Item -->
            <div class="cart-item">
            <div class="item-info">
                <label class="item-select">
                <input type="checkbox" checked>
                <span class="checkmark"></span>
                </label>
                <div class="item-details">
                <h3 class="item-title">The Great Novel</h3>
                <p class="item-price">$19.99</p>
                </div>
            </div>
            <div class="item-controls">
                <div class="quantity-selector">
                <button class="quantity-btn minus">-</button>
                <input type="number" value="1" min="1" class="quantity-input">
                <button class="quantity-btn plus">+</button>
                </div>
                <button class="remove-btn">Remove</button>
            </div>
            </div>
        </div>
    
        <div class="cart-summary">
            <div class="total-price">
            <span>Total:</span>
            <span class="total-amount">$19.99</span>
            </div>
            <button class="checkout-btn">Proceed to Checkout</button>
        </div>
        </div>
    </div>

