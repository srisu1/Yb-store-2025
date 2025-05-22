<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.bookstore.model.User" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home page</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/home.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/modal.css">
    <script>
        const contextPath = "${pageContext.request.contextPath}";
        const isLoggedIn = ${not empty sessionScope.user};  // Check if user is logged in
    </script>
    <script src="https://cdn.lordicon.com/lordicon.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>

<%
    String errorMessage = (String) request.getAttribute("error");
    if (errorMessage != null) {
%>
    <div class="popup-message show"><%= errorMessage %></div>
<%
    }
%>


<!-- Main container that contains the whole layout -->
<div class="Main-Container"> 

    <!-- Section that contains hero section and header starts -->
    <section class="Header-Hero">

        <!-- Header section starts -->
        <jsp:include page="/includes/Header.jsp" />
        <!-- Header section ends -->
        <c:if test="${not empty sessionScope.logoutMessage}">
		    <div class="logout-message">${sessionScope.logoutMessage}</div>
		    <c:remove var="logoutMessage" scope="session"/>
		</c:if>

        <!-- Hero section starts -->
            <div class="Hero-Section">
                <div class="Hero-Image">
                    <a href="#"><img id="hero-img" 
	             src="${pageContext.request.contextPath}resources/images/Book3.png" 
	             alt="Book Showcase"></a>
                </div>
                  
                <div class="Hero-Button">
				  <a href="${pageContext.request.contextPath}/catalog" style="text-decoration:none;">
				    <button class="blob-button" aria-label="Action Button">
				      <span class="blob-text">Next</span>
				      <svg viewBox="0 0 200 200" xmlns="http://www.w3.org/2000/svg">
				        <path 
				          fill="none" 
				          stroke="currentColor" 
				          stroke-width="4" 
				          d="M34.1,-47.8C39.2,-36.5,34.7,-20.9,35.5,-7.6C36.2,5.7,42.3,16.8,38.9,22.4C35.6,27.9,22.9,27.9,11,33.9C-1,39.9,-12.1,51.8,-26.9,54.8C-41.8,57.7,-60.4,51.7,-64.4,39.6C-68.4,27.6,-57.8,9.7,-53.2,-8.1C-48.5,-25.9,-49.9,-43.5,-42,-54.3C-34.2,-65.1,-17.1,-69.1,-1.3,-67.6C14.6,-66.1,29.1,-59.1,34.1,-47.8Z" 
				          transform="translate(100 100)"
				        />
				      </svg>
				    </button>
				  </a>
				</div>


                <div class="Hero-Text">
                    <h1 class="top">Books of</h1>
                   <h1 class="bottom">all genres</h1>
                </div>

            </div>
        <!-- Hero section ends -->
          

    </section>
    <!-- Section that contains hero section and header ends here -->

    <!-- Section that contains main section -->
    <section class="Main-Content">
        <div class="wave-divider">
            <svg class="wave-divider" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1440 320">
                <path fill="#0099ff" fill-opacity="1" d="M0,160L24,170.7C48,181,96,203,144,202.7C192,203,240,181,288,176C336,171,384,181,432,202.7C480,224,528,256,576,272C624,288,672,288,720,245.3C768,203,816,117,864,90.7C912,64,960,96,1008,133.3C1056,171,1104,213,1152,208C1200,203,1248,149,1296,128C1344,107,1392,117,1416,122.7L1440,128L1440,0L1416,0C1392,0,1344,0,1296,0C1248,0,1200,0,1152,0C1104,0,1056,0,1008,0C960,0,912,0,864,0C816,0,768,0,720,0C672,0,624,0,576,0C528,0,480,0,432,0C384,0,336,0,288,0C240,0,192,0,144,0C96,0,48,0,24,0L0,0Z"></path>
            </svg>
        </div>
        
		  <div class="Book-Section">
		    <h2>Best Sellers</h2>
		    <div class="book-container">
		        <a href="catalog?filter=bestSeller" class="show-more-link">Show All</a> <!-- inside book-container -->
		        <c:forEach var="book" items="${bestSellers}">
		            <div class="book-card">
		                <a href="bookdetails?id=${book.bookId}">
		                    <img src="<c:url value='${book.coverImageUrl}' />" alt="Book Cover" />
		                </a>
		                <h3>${book.title}</h3>
		                <p>Rs. ${book.price}</p>
		            </div>
		        </c:forEach>
		    </div>
		
		    <h2>New Arrivals</h2>
		    <div class="book-container">
		        <a href="catalog?filter=newArrivals" class="show-more-link">Show All</a> <!-- inside book-container -->
		        <c:forEach var="book" items="${newArrivals}">
		            <div class="book-card">
		                <a href="bookdetails?id=${book.bookId}">
		                    <img src="<c:url value='${book.coverImageUrl}' />" alt="Book Cover" />
		                </a>
		                <h3>${book.title}</h3>
		                <p>Rs. ${book.price}</p>
		            </div>
		        </c:forEach>
		    </div>
		</div>

    <!-- Section that contains main section ends here -->

    <jsp:include page="/includes/modal.jsp" />

    <!-- Login and Register Modals -->
    <c:if test="${not empty triggerLogin}">
        <script>
            document.addEventListener('DOMContentLoaded', function() {
                document.getElementById('loginOverlay').style.display = 'flex';
                document.body.classList.add('modal-open');
            });
        </script>
    </c:if>

    <c:if test="${not empty triggerRegister}">
        <script>
            document.addEventListener('DOMContentLoaded', function() {
                document.getElementById('registerOverlay').style.display = 'flex';
                document.body.classList.add('modal-open');
            });
        </script>
    </c:if>

    <c:if test="${not empty param.showLogin}">
        <script>
            document.addEventListener('DOMContentLoaded', function() {
                document.getElementById('loginOverlay').style.display = 'flex';
                document.body.classList.add('modal-open');
            });
        </script>
    </c:if>

    <div id="cookieSuccessToast" class="toast">
        <p>Your login is saved. You will stay logged in for a week!</p>
    </div>

    <jsp:include page="/includes/Footer.jsp" />
    
    <script>
    window.addEventListener('DOMContentLoaded', () => {
        const popup = document.querySelector('.popup-message');
        if (popup) {
            setTimeout(() => {
                popup.classList.remove('show');
            }, 4000); // 4 seconds
        }
    });
    </script>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/lottie-web/5.12.0/lottie.min.js"></script>
    <script>
	  const contextPath = '<%= request.getContextPath() %>';
	  const isLoggedIn = '<%= session.getAttribute("user") != null ? "true" : "false" %>';
	</script>
<script src="resources/js/modal.js"></script>
    
    <script src="${pageContext.request.contextPath}/resources/js/modal.js" defer></script>
    <script src="${pageContext.request.contextPath}/resources/js/home.js" defer></script>
</body>
</html>
