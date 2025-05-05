<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="java.util.List" %>
<%@ page import="com.bookstore.model.Book" %>
<%@ page import="com.bookstore.model.Author" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${book.title}</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/modal.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    
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
            display: flex;
            flex-direction: column;
            min-height: 100vh;
            justify-content: center;
            padding: 20px;
            margin-top:30px;
            background-color: #F4EFE3;
        }


Header {

margin-top: 20px;
}

/* Book Detail Layout */
.book-detail-container {
    display: flex;
    flex-wrap: wrap;
    justify-content: space-between;
    gap: 20px;
    padding: 30px;
   	margin: 40px 30px;
    box-shadow: 0 0 12px rgba(255, 255, 255, 0.05);
    
    border-radius: 12px;
}
.Book-card {
width: 100%;
display: flex;
}


.book-cover {
    margin-left: 3%;
    perspective: 1200px;
    display: inline-block;
}

/* Balanced pop-out effect */
.book-cover img {
    max-width: 340px;
    border-radius: 12px;
    transform: translateZ(30px) scale(1.03);
    box-shadow:
        0 15px 25px rgba(0, 0, 0, 0.25),
        0 8px 16px rgba(255, 255, 255, 0.1);
    transform-style: preserve-3d;
    transition: transform 0.4s ease, box-shadow 0.4s ease;
}

/* Subtle depth boost on hover */
.book-cover img:hover {
    transform: translateZ(40px) scale(1.05);
    box-shadow:
        0 20px 35px rgba(0, 0, 0, 0.35),
        0 10px 20px rgba(255, 255, 255, 0.15);
}


/* Book Details */
.book-details {
    flex: 1;
    padding-left: 15%;
    min-width: 300px;
    width: 50%;
	gap: 2%;
	display:flex ;
	flex-direction: column;
	}

.book-details h1 {
    font-size: 36px;
    margin-bottom: 10px;
    color: #000000;
	font-size: 3em;
	font-family: 'Playfair Display';
	    
	}

.book-details .rating,
.book-details .price,
.book-details .description,
.authors {
    margin: 15px 0;
    font-size: 16px;
    
}

.price {
    font-size: 20px;
    font-weight: bold;
    
}

/* Buttons */
button {
    background-color: #007bff;
    color: white;
    border: none;
    padding: 10px 25px;
    border-radius: 6px;
    font-size: 16px;
    margin-top: 10px;
    transition: background-color 0.2s ease;
}

button:hover {
    background-color: #0056b3;
}

/* Description Toggle Links */
.read-more-link,
.read-less-link {
    color: #1e90ff;
    cursor: pointer;
    font-weight: bold;
}

.read-more-link:hover,
.read-less-link:hover {
    text-decoration: underline;
}

/* Related Books */

.related-books {
    padding: 2rem;
    background-color: #F4EFE3;
    width:80%;
    margin: 0 auto;
	margin-top: 10%;
    
    
}

.related-books h3 {
    font-size: 2.5rem;
    text-align: center;
    margin-bottom: 4rem;
    font-weight: 100;
    color: #333;
    font-family:Playfair Display;
}

.related-books-container {
    display: grid;
    grid-template-columns: repeat(4, 1fr); /* 4 items per row on large screens */
    
    justify-items: center;
    background-color: #F4EFE3;
    margin-bottom: 2rem;
    
}

.related-book {
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

.related-book img {
    width: 100%;
    height: 300px;
    border-radius: 8px;
    margin-bottom: 1rem;
}


.related-book p {
    font-size: 1rem;
    color: #666;
    margin: 0.5rem 0;
}




.related-book img:hover {
    transform: translateY(-10px);
    box-shadow: 0 6px 15px rgba(0, 0, 0, 0.15);
}




/* User Reviews */
/* User Reviews Section */
.user-reviews {
    padding: 20px;
    background-color: #f8f9fa;
    border-radius: 10px;
    box-shadow: 0 2px 5px rgba(0,0,0,0.1);
}

.review-card {
    display: grid;
    gap: 2rem;
    background-color: #F4EFE3;
    padding: 20px;
}

.review {
    background-color: white;
    padding: 1.5rem;
    margin-bottom: 1rem;
    border-radius: 8px;
    box-shadow: 0 1px 3px rgba(0,0,0,0.1);
}

.review-rating {
    display: flex;
    align-items: center;
    gap: 0.5rem;
    margin-bottom: 0.5rem;
    color: #ffc107;
}
/* Update stars container for reviews */
.rating-stars {
    display: flex;
    gap: 3px;
}

/* Review stars styling */
.review-rating .fa-star {
    color: #ddd !important; /* Gray empty stars */
    font-size: 1.2rem;
}

.review-rating .fa-star.filled {
    color: #000 !important; /* Black filled stars */
}

/* Form stars styling */
/* Update stars container for reviews */
.rating-stars {
    display: flex;
    gap: 3px;
}

/* Review stars styling */
.review-rating .fa-star {
    color: #ddd !important;
    font-size: 1.2rem;
}

.review-rating .fa-star.filled {
    color: #000 !important;
}

/* Form stars styling */
.stars {
    display: flex;
    flex-direction: row-reverse;
    justify-content: flex-end;
    gap: 5px;
}

.stars input {
    display: none;
}

.stars label .fa-star {
    color: #ddd;
    font-size: 1.8rem;
    cursor: pointer;
    transition: color 0.2s;
}

.stars input:checked ~ label .fa-star,
.stars label:hover .fa-star,
.stars label:hover ~ label .fa-star {
    color: #000;
}

.review-text {
    color: #333;
    line-height: 1.6;
    margin: 1rem 0;
}

.review-date {
    color: #666;
    font-size: 0.9rem;
}

/* Review Form */
.review-form-container {
    background-color: white;
    padding: 2rem;
    border-radius: 10px;
    box-shadow: 0 2px 5px rgba(0,0,0,0.1);
}

.review-form-container h3 {
    margin-bottom: 1.5rem;
    color: #2c3e50;
}

form {
    display: flex;
    flex-direction: column;
    gap: 1rem;
}

textarea {
    width: 100%;
    padding: 1rem;
    border: 1px solid #ddd;
    border-radius: 6px;
    font-family: inherit;
    resize: vertical;
    min-height: 100px;
    transition: border-color 0.3s;
}

textarea:focus {
    outline: none;
    border-color: #3498db;
    box-shadow: 0 0 0 2px rgba(52,152,219,0.2);
}

button[type="submit"] {
    background-color: #000000;
    color: white;
    padding: 12px 24px;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    font-size: 1rem;
    transition: background-color 0.3s;
}

button[type="submit"]:hover {
    background-color: #000000;
}


    


/* Responsive */
@media (max-width: 768px) {
    .book-detail-container {
        flex-direction: column;
        align-items: center;
    }

    .book-details {
        padding-left: 0;
    }

    .related-books-container {
        flex-direction: column;
    }

    .related-book {
        width: 100%;
    }
    .review-card {
        grid-template-columns: 1fr 1fr;
    }
}

.book-details .rating-stars {
    display: inline-flex;
    gap: 3px;
    margin-left: 8px;
}

.book-details .rating-stars .fa-star {
    color: #ddd;
    font-size: 1.4rem;
}

.book-details .rating-stars .fa-star.filled {
    color: #000;
}
.rating span {
    display: none;
}


.read-more-link,
.read-less-link {
    display: block;         /* Ensures it appears below, not inline */
    color: black;           
    text-decoration: underline;  
    margin-top: 6px;        /* Space above the link */
    font-weight: 500;
}

.read-more-link:hover,
.read-less-link:hover {
    text-decoration: underline;  /* Optional hover effect */
}



    
    </style>
</head>
<body>

    <jsp:include page="/includes/HeaderOtherPages.jsp" />
    

    <div class="book-detail-container">
        <!-- Left side: Book Cover Image -->
        <div class="Book-card">
        
        	<div class="book-cover">
            <img src=<c:url value='${book.coverImageUrl}' /> alt="${book.title} Cover">
        </div>

        <!-- Right side: Book Details -->
        <div class="book-details">
             <h1>${book.title}</h1>
		    <div class="rating">
		        
		        <div class="rating-stars">
		            <c:forEach begin="1" end="5" varStatus="loop">
		                <i class="fa-solid fa-star ${loop.index <= averageRating ? 'filled' : ''}"></i>
		            </c:forEach>
		        </div>
		        <span>(${averageRating != null ? averageRating : '0'}/5)</span>
		    </div>
            
            <c:if test="${not empty book.authors}">
			    <div class="authors">
			        <strong>Author(s):</strong>
			        <c:forEach var="author" items="${book.authors}" varStatus="loop">
			            ${author.name}<c:if test="${!loop.last}">, </c:if>
			        </c:forEach>
			    </div>
			</c:if>
            

            <div class="price">
                 Rs. ${book.price}
            </div>

            <div class="description">
			    <strong>Description:</strong>
			    
			    <c:choose>
			        <c:when test="${fn:length(book.description) > 200}">
			            <p>${fn:escapeXml(book.description.substring(0, 200))}...</p>
			        </c:when>
			        <c:otherwise>
			            <p>${fn:escapeXml(book.description)}</p>
			        </c:otherwise>
			    </c:choose>
			
			    <a href="#full-description" class="read-more-link">Read more</a>
			
			    <div id="full-description" class="full-description" style="display:none;">
			        <p>${fn:escapeXml(book.description)}</p>
			        <a href="javascript:void(0);" class="read-less-link">Read less</a>
			    </div>
			</div>


            <form action="add-to-cart" method="post">
                <input type="hidden" name="bookId" value="${book.bookId}">
                <button type="submit" class="btn-add-to-cart">Add to Cart</button>
            </form>

            <form action="add-to-wishlist" method="post">
                <input type="hidden" name="bookId" value="${book.bookId}">
                <button type="submit" class="btn-add-to-wishlist">Add to Wishlist</button>
            </form>
        </div>
        	
        
        </div>
        <!-- Related Books -->
        <div class="related-books">
            <h3>Related Books</h3>
            <div class="related-books-container">
                <c:forEach var="relatedBook" items="${relatedBooks}">
                    <div class="related-book">
                        <a href="bookdetails?id=${relatedBook.bookId}">
                            <img src="${relatedBook.coverImageUrl}" alt="${relatedBook.title}">
                            <h4>${relatedBook.title}</h4>
                            <p>Rs. ${relatedBook.price}</p>
                        </a>
                    </div>
                </c:forEach>
            </div>
        </div>

        <!-- User Reviews Section -->
        <div class="review-card">
        
        	<div class="user-reviews">
	            <h3>User Reviews</h3>
	            <c:forEach var="review" items="${reviews}">
	                <div class="review">
	                    <div class="review-rating">
	                        <strong>Rating:</strong> ${review.rating} / 5
	                    </div>
	                    <div class="review-text">
	                        <p>${review.reviewText}</p>
	                    </div>
	                    <div class="review-date">
	                        <small>Reviewed on: ${review.reviewCreatedAt}</small>
	                    </div>
	                </div>
	            </c:forEach>
            </div>
            
            <div class= "review-form-container">
            	<!-- Review Form -->
	            <h3>Add Your Review</h3>
	            <form action="bookdetails" method="post">
	                <input type="hidden" name="bookId" value="${book.bookId}">
	                <label for="rating">Rating:</label>
	                
					<div class="stars">
					    <input type="radio" name="rating" id="star5" value="5" required>
					    <label for="star5"><i class="fa-solid fa-star"></i></label>
					    <input type="radio" name="rating" id="star4" value="4">
					    <label for="star4"><i class="fa-solid fa-star"></i></label>
					    <input type="radio" name="rating" id="star3" value="3">
					    <label for="star3"><i class="fa-solid fa-star"></i></label>
					    <input type="radio" name="rating" id="star2" value="2">
					    <label for="star2"><i class="fa-solid fa-star"></i></label>
					    <input type="radio" name="rating" id="star1" value="1">
					    <label for="star1"><i class="fa-solid fa-star"></i></label>
					</div>
					
	                <label for="reviewText">Review:</label><br>
	                <textarea name="reviewText" rows="5" cols="50" required></textarea><br>
	
	                <button type="submit">Submit Review</button>
	            </form>
            
            </div>

            
        
        </div>

    </div>
    <jsp:include page="/includes/modal.jsp" />

    <script>
        // Toggle Full Description on Read More/Read Less
        document.querySelectorAll('.read-more-link').forEach(function (link) {
            link.addEventListener('click', function () {
                document.querySelector('.full-description').style.display = 'block';
                link.style.display = 'none';
                document.querySelector('.read-less-link').style.display = 'inline';
            });
        });

        document.querySelectorAll('.read-less-link').forEach(function (link) {
            link.addEventListener('click', function () {
                document.querySelector('.full-description').style.display = 'none';
                link.style.display = 'none';
                document.querySelector('.read-more-link').style.display = 'inline';
            });
        });
        
        document.addEventListener('DOMContentLoaded', function() {
            // Convert review ratings to stars
            document.querySelectorAll('.review-rating').forEach(ratingDiv => {
                const ratingText = ratingDiv.textContent;
                const ratingValue = parseFloat(ratingText.match(/\d+(\.\d+)?/)[0]);
                
                // Clear existing content
                ratingDiv.innerHTML = '';
                
                const starsContainer = document.createElement('div');
                starsContainer.className = 'rating-stars';
                
                // Create filled stars
                for (let i = 0; i < Math.floor(ratingValue); i++) {
                    const star = document.createElement('i');
                    star.className = 'fa-solid fa-star filled';
                    starsContainer.appendChild(star);
                }
                
                // Create remaining empty stars
                for (let i = Math.floor(ratingValue); i < 5; i++) {
                    const star = document.createElement('i');
                    star.className = 'fa-solid fa-star';
                    starsContainer.appendChild(star);
                }
                
                ratingDiv.appendChild(starsContainer);
            });

            // Convert book's average rating to stars
            const bookRating = parseFloat(${averageRating});
            const bookStarsContainer = document.querySelector('.book-details .rating-stars');
            
            if (bookStarsContainer) {
                // Clear existing content
                bookStarsContainer.innerHTML = '';
                
                // Create filled stars
                for (let i = 0; i < Math.floor(bookRating); i++) {
                    const star = document.createElement('i');
                    star.className = 'fa-solid fa-star filled';
                    bookStarsContainer.appendChild(star);
                }
                
                // Create remaining empty stars
                for (let i = Math.floor(bookRating); i < 5; i++) {
                    const star = document.createElement('i');
                    star.className = 'fa-solid fa-star';
                    bookStarsContainer.appendChild(star);
                }
                
                // Add numerical rating display
                const numericalRating = document.createElement('span');
                numericalRating.textContent = `(${bookRating.toFixed(1)}/5)`;
                numericalRating.style.marginLeft = '8px';
                bookStarsContainer.parentNode.appendChild(numericalRating);
            }
        });
    </script>
    
   
    
    
    <script src="${pageContext.request.contextPath}/resources/js/modal.js" defer></script>

</body>
</html>
