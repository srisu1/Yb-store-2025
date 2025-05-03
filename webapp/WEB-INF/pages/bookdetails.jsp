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
    <link rel="stylesheet" href="resources/css/styles.css">
    <style>
    /* General body and layout styles */
/* Base Reset and Background */
body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    margin: 0;
    padding: 0;
    background-color: #111;
    color: #f5f5f5;
}

/* Navbar */
nav {
    background-color: #000;
    padding: 12px 20px;
    text-align: center;
}

nav a {
    color: #f5f5f5;
    text-decoration: none;
    margin: 0 15px;
    font-weight: 500;
}

nav a:hover {
    text-decoration: underline;
}

/* Book Detail Layout */
.book-detail-container {
    display: flex;
    flex-wrap: wrap;
    justify-content: space-between;
    gap: 20px;
    padding: 30px;
    background-color: #1c1c1c;
    box-shadow: 0 0 12px rgba(255, 255, 255, 0.05);
    max-width: 1200px;
    margin: 30px auto;
    border-radius: 12px;
}

/* Book Cover */
.book-cover img {
    max-width: 300px;
    border-radius: 8px;
    box-shadow: 0 0 10px rgba(255, 255, 255, 0.1);
}

/* Book Details */
.book-details {
    flex: 1;
    padding-left: 30px;
    min-width: 300px;
}

.book-details h1 {
    font-size: 36px;
    color: #fff;
    margin-bottom: 10px;
}

.book-details .rating,
.book-details .price,
.book-details .description,
.authors {
    margin: 15px 0;
    font-size: 16px;
    color: #ccc;
}

.price {
    font-size: 20px;
    font-weight: bold;
    color: #ffd700;
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
    width: 100%;
    margin-top: 50px;
}

.related-books h3 {
    font-size: 24px;
    color: #f5f5f5;
    margin-bottom: 20px;
}

.related-books-container {
    display: flex;
    gap: 20px;
    overflow-x: auto;
    padding-bottom: 10px;
}

.related-book {
    background-color: #222;
    padding: 15px;
    border-radius: 10px;
    min-width: 180px;
    box-shadow: 0 0 8px rgba(255, 255, 255, 0.05);
    text-align: center;
}

.related-book img {
    width: 100%;
    border-radius: 6px;
    margin-bottom: 10px;
}

.related-book h4 {
    font-size: 18px;
    color: #eee;
}

.related-book p {
    color: #aaa;
    font-size: 14px;
}

/* User Reviews */
.user-reviews {
    margin-top: 40px;
}

.user-reviews h3 {
    font-size: 24px;
    margin-bottom: 20px;
    color: #f5f5f5;
}

.review {
    background-color: #1a1a1a;
    padding: 15px;
    margin-bottom: 20px;
    border-radius: 8px;
    color: #ccc;
}

.stars {
        display: flex;
        flex-direction: row-reverse;
        justify-content: flex-start;
    }

    .stars input {
        display: none;
    }

    .stars label {
        font-size: 2rem;
        color: lightgray;
        cursor: pointer;
        transition: color 0.2s;
    }

    .stars input:checked ~ label,
    .stars label:hover,
    .stars label:hover ~ label {
        color: gold;
    }

.review-date {
    font-size: 12px;
    color: #888;
}

/* Forms */
form {
    margin-top: 20px;
}

textarea,
select {
    background-color: #2a2a2a;
    color: #fff;
    border: 1px solid #444;
    padding: 10px;
    border-radius: 5px;
    width: 100%;
    margin-bottom: 10px;
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
}

    
    </style>
</head>
<body>

    <!-- Navigation Bar (simplified for this example) -->
    <nav>
        <a href="home.jsp">Home</a> | <a href="catalogue.jsp">Catalogue</a>
    </nav>

    <div class="book-detail-container">
        <!-- Left side: Book Cover Image -->
        <div class="book-cover">
            <img src="${book.coverImageUrl}" alt="${book.title} Cover">
        </div>

        <!-- Right side: Book Details -->
        <div class="book-details">
            <h1>${book.title}</h1>
            <div class="rating">
                <strong>Rating:</strong> ${averageRating != null ? averageRating : 'No ratings yet'} / 5
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
                <strong>Price:</strong> Rs. ${book.price}
            </div>

            <div class="description">
                <strong>Description:</strong>
                <p>
                    <c:choose>
                        <c:when test="${fn:length(book.description) > 200}">
                            ${fn:escapeXml(book.description.substring(0, 200))}...
                        </c:when>
                        <c:otherwise>
                            ${fn:escapeXml(book.description)}
                        </c:otherwise>
                    </c:choose>
                    <a href="#full-description" class="read-more-link">Read more</a>
                </p>
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

            <!-- Review Form -->
            <h3>Add Your Review</h3>
            <form action="bookdetails" method="post">
                <input type="hidden" name="bookId" value="${book.bookId}">
                <label for="rating">Rating:</label>
                
				<div class="stars">
				    <input type="radio" name="rating" id="star5" value="5" required><label for="star5">&#9733;</label>
				    <input type="radio" name="rating" id="star4" value="4"><label for="star4">&#9733;</label>
				    <input type="radio" name="rating" id="star3" value="3"><label for="star3">&#9733;</label>
				    <input type="radio" name="rating" id="star2" value="2"><label for="star2">&#9733;</label>
				    <input type="radio" name="rating" id="star1" value="1"><label for="star1">&#9733;</label>
				</div>
				
                <label for="reviewText">Review:</label><br>
                <textarea name="reviewText" rows="5" cols="50" required></textarea><br>

                <button type="submit">Submit Review</button>
            </form>
        </div>

    </div>

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
    </script>

</body>
</html>

