<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ page import="com.bookstore.model.Book" %>
<%@ page import="com.bookstore.model.Category" %>

<!DOCTYPE html>
<html>
<head>
    <title>Book Catalogue</title>
    <style>
        *{
		    margin: 0;
		    padding: 0;
		    box-sizing: border-box;
		}
		
		@font-face {
		    font-family: 'Playfair Display'; 
		    src: url(fonts/PlayfairDisplay-VariableFont_wght.ttf);
		    font-weight: 200 300;
		  }
		  
		  @font-face {
		    font-family: 'Karla'; 
		    src: url(fonts/Karla-VariableFont_wght.ttf);
		    font-weight: 500 500;
		  }
		  
		  
        body {
            margin: 1rem;
            background-color: #F3EFE4;
        }

        .Header {
            background-color: #F4EFE3 !important;
        }
		  
  
		  .main-container {
		  display: flex;
		  gap: 15%;
		}
		       

        /* Filters Panel */
        .filters-panel {
            width: 280px;
            min-width: 280px;
            padding: 15px;
            background: #F4EFE3;
            border-right: 1px solid #eee;
            
        }

        .filter-group {
            margin-bottom: 25px;
        }

        .filter-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 12px 0;
            cursor: pointer;
            border-bottom: 1px solid #ddd;
        }

        .filter-options {
            padding: 8px 0;
            max-height: 0;
            overflow: hidden;
            transition: max-height 0.3s ease-out;
        }

        .filter-options.active {
            max-height: 500px;
        }

        .filter-option {
            padding: 8px 0;
            display: flex;
            align-items: center;
            gap: 8px;
            border-bottom: 1px solid #f0f0f0;
        }

        /* Book Grid */
        .book-grid {
            flex-grow: 1;
            display: grid;
           grid-template-columns: 1fr 1fr 1fr;
			gap: 15px;
			width: 50%;
        }

       .Book-Section h2 {
    font-size: 2.5rem;
    text-align: center;
    margin-bottom: 4rem;
    font-weight: 100;
    color: #333;
    font-family:Playfair Display;
}

.book-container {
    display: grid;
    grid-template-columns: repeat(4, 1fr); /* 4 items per row on large screens */
    
    justify-items: center;
    background-color: #F4EFE3;
    margin-bottom: 2rem;
    
}

.book-card {
    background-color: #F4EFE3;
    padding: 1rem;
    border-radius: 10px;
    
    transition: transform 0.3s ease, box-shadow 0.3s ease;
    width: 100%;
    max-width: 240px;
    text-align: center;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: space-around;
    
}

.book-card img {
    width: 100%;
    height: 500px;
    border-radius: 8px;
    margin-bottom: 1rem;
}

.book-card h3 {
    font-size: 1rem;
    color: #333;
    margin: 0.1rem ;
    font-family:Karla;
}

.book-card p {
    font-size: 1rem;
    color: #666;
    margin: 0.5rem 0;
}


.book-card img {
    transition: transform 0.3s ease, box-shadow 0.3s ease;  /* Smooth transition */
}

.book-card img:hover {
    transform: translateY(-10px);
    box-shadow: 0 6px 15px rgba(0, 0, 0, 0.15);
}

        /* Footer */
        .catalogue-footer {
            padding: 25px;
            text-align: center;
            background: #f8f8f8;
            border-top: 1px solid #eee;
            margin-top: auto;
        }

        /* Interactive Elements */
        .toggle-btn {
            cursor: pointer;
            font-size: 18px;
            user-select: none;
        }

        .action-buttons {
            margin-top: 25px;
            display: flex;
            gap: 12px;
        }

        button {
            padding: 10px 25px;
            border: 1px solid #ddd;
            background: #f8f8f8;
            cursor: pointer;
            transition: all 0.2s;
        }

        button:hover {
            background: #eee;
        }
       
		
		
		
		
		.no-results {
		    grid-column: 1 / -1;
		    text-align: center;
		    padding: 2rem;
		    font-size: 1.2rem;
		    color: #666;
		}
		
		
    </style>
</head>
<body>
    <jsp:include page="/includes/HeaderOtherPages.jsp" />

    <div class="main-container">
        <!-- Filters Panel -->
        <div class="filters-panel">
            <h2>REFINE THE SELECTION</h2>

            <!-- Category Filter Section -->
            <div class="filter-group">
                <div class="filter-header" onclick="toggleFilter(this)">
                    <span>CATEGORIES</span>
                    <span class="toggle-btn">+</span>
                </div>
                <div class="filter-options">
                    <c:forEach var="category" items="${categories}">
                        <div class="filter-option">
                            <input type="radio" name="categoryFilter" value="${category.categoryId}" id="category-${category.categoryId}" />
                            <label for="category-${category.categoryId}">${category.categoryName}</label>
                        </div>
                    </c:forEach>
                </div>
            </div>

            <div class="action-buttons">
                <button onclick="filterBooks()">APPLY FILTER</button>
                <button>CANCEL</button>
            </div>
        </div>

        <!-- In the book grid section -->
		<div class="book-grid">
		    <c:choose>
		        <c:when test="${not empty books}">
		            <c:forEach var="book" items="${books}">
		                <div class="book-card">
		                	<a href="bookdetails?id=${book.bookId}">
		                		<img src=<c:url value='${book.coverImageUrl}' /> alt="${book.title}" 
		                         style="width: 100%; height: 200px; object-fit: cover;">
		                	
		                	 </a>
		                    
		                    <div class="book-title">${book.title}</div>
		                    <div class="book-author">
		                        <c:forEach items="${book.authors}" var="author" varStatus="loop">
		                            ${author.name}<c:if test="${not loop.last}">, </c:if>
		                        </c:forEach>
		                    </div>
		                    <div class="book-price">Rs. ${book.price}</div>
		                </div>
		            </c:forEach>
		        </c:when>
		        <c:otherwise>
		            <div class="no-results">No books found in this category</div>
		        </c:otherwise>
		    </c:choose>
		</div>

    <script>
        // Toggle filter sections
        function toggleFilter(element) {
            const options = element.parentElement.querySelector('.filter-options');
            const toggleBtn = element.querySelector('.toggle-btn');
            
            options.classList.toggle('active');
            toggleBtn.textContent = options.classList.contains('active') ? '-' : '+';
        }

        // Apply filter based on selected category
        function filterBooks() {
            const selectedCategoryId = document.querySelector('input[name="categoryFilter"]:checked')?.value;
            if (selectedCategoryId) {
                // Assuming the current page will refresh with the filtered books
                window.location.href = '/catalog?categoryId=' + selectedCategoryId;
            }
        }

        // Initialize first filter
        document.querySelector('.filter-header').click();
        
        
        function filterBooks() {
            const selectedCategoryId = document.querySelector('input[name="categoryFilter"]:checked')?.value;
            if (selectedCategoryId) {
                window.location.href = '${pageContext.request.contextPath}/catalog?categoryId=' + selectedCategoryId;
            }
        }

        // Initialize first category as checked
        document.addEventListener('DOMContentLoaded', () => {
            const firstRadio = document.querySelector('input[name="categoryFilter"]');
            if (firstRadio) firstRadio.checked = true;
        });
    </script>

    <script src="${pageContext.request.contextPath}/resources/js/modal.js" defer></script>
</body>
</html>