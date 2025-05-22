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
		    
		  }
		  
		
         body {
            display: flex;
            flex-direction: column;
            min-height: 100vh;
            justify-content: center;
            padding: 20px;
            margin: 1rem;
            background-color: #F3EFE4;
            padding-top: 40px;!important
        }

        .Header {
            background-color: #F4EFE3 !important;
            margin-top: 40px;
        }
		  
  
		  .main-container {
		  display: flex;
		  gap: 15%;
		}
		span{
		font-family:'Karla';
		}
		       

/* Filters Panel */
.filters-panel {
    width: 300px;
    padding: 50px;
    
    background-color: #f3efe4;
    font-family: 'Karla';
    font-size: 14px;
    display: flex;
    flex-direction: column;
    gap: 5px;
}

.filters-panel h2 {
    font-size: 16px;
    font-weight: bold;
    margin-bottom: 10px;
    text-transform: uppercase;
}

.filters-panel hr {
    border: none;
    border-top: 1px solid #444;
    margin: 12px 0;
}

.filters-panel .active-filters {
    font-size: 13px;
    color: #555;
    padding: 4px 0;
}

.filters-panel .filter-group {
    margin-bottom: 15px;
}

.filters-panel .filter-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    font-weight: bold;
    cursor: pointer;
    padding: 5px 0;
}

.filters-panel .filter-header .toggle-btn {
    font-size: 18px;
    user-select: none;
}

.filters-panel .filter-options {
    display: none;
    margin-top: 6px;
    padding-left: 8px;
}

.filters-panel .filter-options.active {
    display: block;
}

.filters-panel .filter-options label {
    display: block;
    margin-bottom: 6px;
    cursor: pointer;
}

.filters-panel .filter-options input[type="text"] {
    width: 100%;
    padding: 6px;
    margin-bottom: 8px;
    border: 1px solid #bbb;
    border-radius: 4px;
    box-sizing: border-box;
}

.filters-panel .price-controls {
    display: flex;
    justify-content: space-between;
    gap: 5px;
    margin-bottom: 10px;
}

.filters-panel .price-controls input[type="number"] {
    flex: 1;
    padding: 5px;
    border: 1px solid #444;
    background: #f3efe4;
    border-radius: 4px;
    box-sizing: border-box;
}

.filters-panel .price-slider {
    position: relative;
    height: 30px;
    margin-top: 5px;
}

.filters-panel .price-slider input[type="range"] {
    position: absolute;
    width: 100%;
    pointer-events: none;
    -webkit-appearance: none;
    height: 6px;
    background: #ddd;
    border-radius: 4px;
}

.filters-panel .price-slider input[type="range"]::-webkit-slider-thumb {
    pointer-events: all;
    width: 14px;
    height: 14px;
    border-radius: 50%;
    background: #444;
    cursor: pointer;
    -webkit-appearance: none;
}

.filters-panel .price-slider input[type="range"]::-moz-range-thumb {
    pointer-events: all;
    width: 14px;
    height: 14px;
    border-radius: 50%;
    background: #444;
    cursor: pointer;
}

.filters-panel .action-buttons {
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    margin-top: 20px;
    gap: 10px;
}

.filters-panel .action-buttons button {
    flex: 1;
    padding: 8px 12px;
    border: none;
    background-color: #444;
    color: #fff;
    cursor: pointer;
    border-radius: 4px;
    font-weight: bold;
    text-transform: uppercase;
    transition: background-color 0.2s ease;
}

.filters-panel .action-buttons button:hover {
    background-color: #222;
}
.filter-options {
  display: none;
}

.filter-options.active {
  display: block;
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
    width: 80%; /* Shrinks image inside the card */
    aspect-ratio: 2 / 3;
    object-fit: cover;
    border-radius: 8px;
    margin-bottom: 1rem;
    transition: transform 0.3s ease, box-shadow 0.3s ease;
}


.book-card .book-title {
    font-size: 1rem;
    color: #333;
    margin: 0.1rem;
    font-family: Karla;
}

.book-card .book-author,
.book-card .book-price {
    font-size: 1rem;
    color: #666;
    margin: 0.5rem 0;
    font-family: Karla;
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
        <form id="filterForm" method="get" action="${pageContext.request.contextPath}/catalog">
		    <div class="filters-panel">
		        <h2>REFINE THE SELECTION</h2>
		        <hr>
		
		        <!-- Active Filters Display -->
		        <div class="active-filters" id="activeFilters"></div>
		        
		
		        <!-- Sort Filter -->
		      
				<form method="get" action="${pageContext.request.contextPath}/catalog" id="sortForm">
				    <div class="filter-group">
				        <div class="filter-header" onclick="toggleFilter(this)">
				            <span>SORT</span>
				            <span class="toggle-btn">+</span>
				        </div>
				        <div class="filter-options">
				            <label><input type="radio" name="sortBy" value="low-to-high" onchange="document.getElementById('sortForm').submit();"> Price: Low to High</label><br>
				            <label><input type="radio" name="sortBy" value="high-to-low" onchange="document.getElementById('sortForm').submit();"> Price: High to Low</label><br>
				            <label><input type="radio" name="sortBy" value="newest" onchange="document.getElementById('sortForm').submit();"> Newest Arrivals</label><br>
				            <label><input type="radio" name="sortBy" value="bestseller" onchange="document.getElementById('sortForm').submit();"> Best Sellers</label><br>
				            <label><input type="radio" name="sortBy" value="books-of-the-week" onchange="document.getElementById('sortForm').submit();"> Books Of The Week</label>
				        </div>
				    </div>
				</form>


		        <hr>
		
		   
			   <!-- Author Filter -->
				<div class="filter-group">
				    <div class="filter-header" onclick="toggleFilter(this)">
				        <span>AUTHOR</span>
				        <span class="toggle-btn">+</span>
				    </div>
				    <div class="filter-options">
				        <input 
				            type="text" 
				            name="authorName" 
				            placeholder="Search author..." 
				            value="${param.authorName != null ? param.authorName : ''}">
				    </div>
				</div>

		        <hr>
		
		        <!-- Category Filter -->
		        <div class="filter-group">
		            <div class="filter-header" onclick="toggleFilter(this)">
		                <span>CATEGORY</span>
		                <span class="toggle-btn">+</span>
		            </div>
		            <div class="filter-options">
		                <c:forEach var="category" items="${categories}">
		                    <label>
		                        <input type="radio" name="categoryId" value="${category.categoryId}"> ${category.categoryName}
		                    </label>
		                </c:forEach>
		            </div>
		        </div>
		        <hr>
		

		        <!-- Price Filter -->
				<div class="filter-group">
				    <span>PRICE</span>
				    
				    <!-- Numeric Inputs -->
				    <div class="price-controls">
				        <input type="number" id="priceMinInput" name="minPrice" min="0" max="10000" step="10" value="0" oninput="syncSliderFromInput()">
				        <input type="number" id="priceMaxInput" name="maxPrice" min="0" max="10000" step="10" value="10000" oninput="syncSliderFromInput()">
				    </div>
				    
				    <!-- Sliders -->
				    <div class="price-slider">
				        <input type="range" id="priceMin" min="0" max="10000" step="10" value="0" oninput="updatePriceDisplay()">
				        <input type="range" id="priceMax" min="0" max="10000" step="10" value="10000" oninput="updatePriceDisplay()">
				    </div>
				</div>

		
		        <!-- Action Buttons -->
		        <div class="action-buttons">
		            <button type="submit">APPLY FILTER</button>
		            <button type="submit" name="clearFilters" value="true">REMOVE ALL FILTERS</button>

		        </div>
		    </div>
		</form>
        
	  





        <!-- In the book grid section -->
		<div class="book-grid">
		    <c:choose>
		        <c:when test="${not empty books}">
		            <c:forEach var="book" items="${books}">
		                <div class="book-card">
		                	<a href="bookdetails?id=${book.bookId}">
		                		<img src=<c:url value='${book.coverImageUrl}' /> alt="${book.title}">
		                	
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
		<c:if test="${totalPages > 1}">
		    <div class="pagination">
		        <c:forEach var="i" begin="1" end="${totalPages}">
		            <c:choose>
		                <c:when test="${i == currentPage}">
		                    <span class="current">${i}</span>
		                </c:when>
		                <c:otherwise>
		                    <a href="${pageContext.request.contextPath}/catalog?page=${i}">${i}</a>
		                </c:otherwise>
		            </c:choose>
		        </c:forEach>
		    </div>
		</c:if>
		

    <script>
    function toggleFilter(element) {
        const options = element.nextElementSibling;
        const toggleBtn = element.querySelector('.toggle-btn');
        options.classList.toggle('active');
        toggleBtn.textContent = options.classList.contains('active') ? '-' : '+';
    }

    function updatePriceDisplay() {
        const minSlider = document.getElementById('priceMin');
        const maxSlider = document.getElementById('priceMax');
        let min = parseInt(minSlider.value);
        let max = parseInt(maxSlider.value);

        if (isNaN(min)) min = 0;
        if (isNaN(max)) max = 10000;

        if (min > max) {
            [min, max] = [max, min];
            minSlider.value = min;
            maxSlider.value = max;
        }

        document.getElementById('priceMinInput').value = min;
        document.getElementById('priceMaxInput').value = max;
    }

    function syncSliderFromInput() {
        let min = parseInt(document.getElementById('priceMinInput').value);
        let max = parseInt(document.getElementById('priceMaxInput').value);

        min = isNaN(min) ? 0 : min;
        max = isNaN(max) ? 10000 : max;

        if (min > max) [min, max] = [max, min];

        document.getElementById('priceMin').value = min;
        document.getElementById('priceMax').value = max;
    }

    function searchAuthor(input) {
        const filter = input.value.toLowerCase();
        document.querySelectorAll('#authorList label').forEach(label => {
            const text = label.textContent.toLowerCase();
            label.style.display = text.includes(filter) ? 'block' : 'none';
        });
    }

    
</script>



    
</body>
</html>