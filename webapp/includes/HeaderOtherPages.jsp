<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script src="https://cdn.lordicon.com/lordicon.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<script src="https://unpkg.com/@lottiefiles/lottie-player@latest/dist/lottie-player.js"></script>



<style>
    

   * {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

body {
  font-family: 'Karla', sans-serif;
  font-weight: 500 500;
  margin-top:0px;
  padding-top:0px;
  /* line-height: 1; */
}

/* Grid-based Header */
.Header {
  display: grid;
  grid-template-columns: 1fr auto 1fr;
  align-items: flex-start;
  padding: 0px 45px;
  width: 100%;
 
  
}

.logo {
  display: flex;
  align-items: center;
  padding-top:-80px;
  height:70%;
}

#logo-animation {
  width: clamp(80px, 10vw, 180px);
  height: auto;
  aspect-ratio: 1/1;
  
 
}

/* Navbar */
.Navbar {
  display: flex;
  justify-content: center;
  align-items: flex-start;
  padding-top:30px;
}

.Navbar-Options {
  display: flex;
  gap: 1.5rem;
  list-style: none;
}

.Navbar-Options li a {
  text-decoration: none;
  color: black;
  font-size: 1rem;
  transition: 0.3s;
  font-size: clamp(0.8rem, 0.9vw, 1.1rem); /* Fluid font sizing */
  padding: 0.3rem 0.4rem;
}

.Navbar-Options li a:hover {
  color: #666;
}

/* Icons */
.Icons {
  display: flex;
  justify-content: flex-end;
  align-items: flex-start;
  position: relative;
  padding-top:30px;
}

.icon-list {
  display: flex;
  gap: 15px;
  list-style: none;
}

.icon-list li a {
  display: flex;
  align-items: center;
}

.menu-toggle {
  display: none;
  font-size: 1.5rem;
  cursor: pointer;
}

/* Books Dropdown */
.Books-Drop-Down-List {
  position: relative;
}

.Drop-Down-List-Container {
  display: none;
  position: absolute;
  top: 100%;
  left: 0;
  min-width: 800px;
  background: #fff;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
  padding: 2rem;
  z-index: 1000;
  gap: 2rem;
  flex-direction: row;
  justify-content: space-between;
}

.Books-Drop-Down-List:hover .Drop-Down-List-Container {
  display: flex;
}
.Books-Drop-Down-List:hover .Drop-Down-List-Container,
.Books-Drop-Down-List.active .Drop-Down-List-Container {
    display: flex;
}

/* Chevron Animation */
.fa-chevron-down {
    transition: transform 0.3s ease;
    margin-left: 8px;
}

.Books-Drop-Down-List.active .fa-chevron-down,
.Books-Drop-Down-List:hover .fa-chevron-down {
    transform: rotate(180deg);
}


/* Responsive Styles */
@media (max-width: 800px) {
  .Header {
    grid-template-columns: 1fr auto;
    grid-template-rows: auto auto;
    row-gap: 10px;
  }

  .Navbar {
    grid-column: 1 / -1;
    display: none;
    flex-direction: column;
    background: #f8f8f8;
    padding: 1rem;
  }

  .Navbar.active {
    display: flex;
  }

  .menu-toggle {
    display: block;
  }

  .icon-list {
    display: none;
    position: absolute;
    right: 0;
    top: 100%;
    background: #fff;
    flex-direction: column;
    padding: 1rem;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    z-index: 1000;
  }

  .icon-list.active {
    display: flex;
  }
}



lottie-player {
  color: var(--theme-text);
  transition: color 0.5s ease !important;
}

lottie-player path {
  fill: currentColor !important;
  stroke: currentColor !important;
}
.Drop-Down-Middle-Portion-Books-Of-The-Week-Pictures {
    display: flex;
    gap: 10px;
    padding: 0;
    margin: 0;
}

.weekly-book-image {
    width: 100px;
    height: 150px;
    object-fit: cover;
    border-radius: 4px;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
}



</style>





</head>
<body>

	 <header class="Header">


       <a href="<%= request.getContextPath() %>/" class="logo">
          <lottie-player
            id="logo-animation"
            src="${pageContext.request.contextPath}/resources/icons/yonder.json"
            background="transparent"
            speed="1"
            style="width: clamp(80px, 10vw, 180px); height: auto;"
            autoplay>
          </lottie-player>
        </a>
        


      




      <!-- Navbar starts here -->
	    <div class="Navbar">
	        <ul class="Navbar-Options" style="list-style: none;">
	            <!-- Drop-Down from books start here -->
	            <li class="Books-Drop-Down-List">
	                <a href="#" role="button" aria-haspopup="true" aria-expanded="false">
	                    BOOKS <i class="fa-solid fa-chevron-down"></i>
	                </a>
	                <section class="Drop-Down-List-Container" aria-label="Books submenu">
	                    <div class="Genre_Drop-Down">
	                        <h6 class="dropdown-section-header">Categories</h6>
	                        <ul class="Genre_Drop-Down-Options" style="list-style: none;">
	                            <c:forEach items="${categories}" var="category">
	                                <li><a href="catalog?categoryId=${category.categoryId}" class="dropdown-link" data-category-id="${category.categoryId}">
	                                    ${category.categoryName}
	                                </a></li>
	                            </c:forEach>
	                        </ul>
	                        
	                       
							
	                    </div>
	
	                    <div class="Drop-Down-Middle-Portion">
	                        <div class="Drop-Down-Middle-Portion-Top">
	                            <h6 class="dropdown-section-header">Quick Links</h6>
	                            <ul class="Drop-Down-Middle-Portion-Top" style="list-style: none;">
	                                <li><a href="catalog?filter=bestSeller" class="dropdown-link">Best Sellers</a></li>
	                                <li><a href="catalog?filter=newArrivals" class="dropdown-link">New Arrivals</a></li>
	                                <li><a href="catalog?filter=popular" class="dropdown-link">Popular</a></li>
	                            </ul>
	                        </div>
	
	                        <div class="Drop-Down-Middle-Portion-Books-Of-The-Week">
	                            <h5 class="Drop-Down-Middle-Portion-Heading">Books Of The Week</h5>
	                            <ul class="Drop-Down-Middle-Portion-Books-Of-The-Week-Pictures" style="list-style: none;">
	                                <!-- Dynamic Books of the Week -->
	                                <c:forEach items="${booksOfWeek}" var="book" end="3">
	                                    <li>
	                                        <a href="bookdetails?id=${book.bookId}">
	                                            <img src="<c:url value='${book.coverImageUrl}' />" alt="${book.title} cover" class="weekly-book-image">
	
	                                        </a>
	                                    </li>
	                                </c:forEach>
	                            </ul>
	                        </div>
	                    </div>
	
	                    <div class="Drop-Down-Others">
	                        <h6 class="dropdown-section-header">Other Services</h6>
	                        <ul class="Drop-Down-Others-Options" style="list-style: none;">
	                            <li><a href="bundle-deals" class="dropdown-link">Bundle Deals</a></li>
	                            <li><a href="used-books" class="dropdown-link">Used Books</a></li>
	                            <li><a href="wishlist" class="dropdown-link">Wishlist</a></li>
	                            <li><a href="book-request" class="dropdown-link">Book Request</a></li>
	                        </ul>
	                    </div>
	                </section>
	            </li>
	            <!-- Drop-Down from books ends here -->
	
	            <li><a href="${pageContext.request.contextPath}/catalog">ALL</a></li>
	            <li><a href="${pageContext.request.contextPath}/pages/about">ABOUT</a></li>
	            <li><a href="${pageContext.request.contextPath}/pages/contact">CONTACT</a></li>
	        </ul>
	    </div>
    <!-- Navbar ends here -->

        <!-- Icons starts here -->
        <div class="Icons">
                <a href="javascript:void(0);" class="menu-toggle">
                    <i class="fa fa-bars"></i>
                </a>

            <ul class="icon-list"  style="list-style: none;">
                        <li>
                          <a href="#" id="loginTrigger">
	                       <lord-icon src="${pageContext.request.contextPath}/resources//icons/wired-outline-21-avatar-hover-looking-around.json"
					           trigger="loop" 
					           style="width:30px;height:30px">
					       </lord-icon>
	                      </a>
                        </li>
                        <li>
                          <a href="#" id="searchTrigger">
	                       <lord-icon src="${pageContext.request.contextPath}/resources//icons/wired-outline-19-magnifier-zoom-search-hover-spin-2.json"
					           trigger="loop" 
					           delay="2000"
					           style="width:30px;height:30px">
					       </lord-icon>
	                      </a>
                        </li>
                         <li>
                          <a href="#">
	                       <lord-icon src="${pageContext.request.contextPath}/resources//icons/wired-outline-20-love-heart-morph-glitter.json"
					           trigger="hover" 
					           style="width:30px;height:30px">
					       </lord-icon>
	                      </a>
                        </li>
                        <li>
                          <a href="#" id="cartTrigger">
	                       <lord-icon src="${pageContext.request.contextPath}/resources//icons/wired-outline-139-basket-morph-fill.json"
					           trigger="hover" 
					           style="width:30px;height:30px">
					       </lord-icon>
	                      </a>
	                      <span id="isLoggedIn" style="display:none;">
						  <% if (session.getAttribute("user") != null) { %>true<% } else { %>false<% } %>
						</span>
	                      
                        </li>
                        
                       
                        
                      </ul>
            </div>

        </div>
        <!-- Icons ends here -->





    </header>
    <!-- Header section ends -->
    <script>
	document.addEventListener('DOMContentLoaded', function () {
	  const toggleBtn = document.querySelector('.menu-toggle');
	  const navbar = document.querySelector('.Navbar');
	  const iconList = document.querySelector('.icon-list');
	
	  toggleBtn.addEventListener('click', function (e) {
	    e.stopPropagation();
	    navbar.classList.toggle('active');
	    iconList.classList.toggle('active');
	  });
	
	  document.addEventListener('click', function (e) {
	    if (!e.target.closest('.Icons') && !e.target.closest('.Navbar')) {
	      navbar.classList.remove('active');
	      iconList.classList.remove('active');
	    }
	  });
	});
</script>
<script src="https://unpkg.com/@lottiefiles/lottie-player@latest/dist/lottie-player.js"></script>

	

</body>
</html>