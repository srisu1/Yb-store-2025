<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page import="com.bookstore.dao.BookDAO, com.bookstore.model.Book, java.util.*"%>

<!DOCTYPE html>
<html>
<head>
    <title>Book Admin Panel</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/css/select2.min.css" rel="stylesheet" />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/js/select2.min.js"></script>
    <script src="https://cdn.lordicon.com/lordicon.js"></script>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
	<script src="https://unpkg.com/@lottiefiles/lottie-player@latest/dist/lottie-player.js"></script>
	
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">
    
    
    <style>
    
    
    
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
       

      /*   :root {
        --primary-green: #4CAF50;
        --active-blue: #3B82F6;
        --background-beige: #F4EFE3;
        --text-dark: #2c3e50;
        --text-light: #7f8c8d;
        --border-color: #ecf0f1;
    } */

    /* Base Styles */
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
        font-family: 'Karla', sans-serif;
    }

    body {
        background: #F4EFE3;
        color: var(--text-dark);
        line-height: 1.6;
    }

    .container {
        display: grid;
        grid-template-columns: 250px 1fr;
        min-height: 100vh;
        gap: 2rem;
        padding: 2rem;
    }

    /* Sidebar Styles */
    .sidebar {
        position: sticky;
        top: 2rem;
        height: fit-content;
        padding: 2rem;
        background: #f4efe3;
        border-radius: 1rem;
        
        display: flex;
        flex-direction: column;
        justify-content: space-between;
    }

    .nav-middle ul, .nav-end {
        border: 2px solid var(--text-dark);
        border-radius: 2em;
        padding: 1rem 0;
        margin: 2rem 0;
        list-style: none;
        width: 35%;
        /*! display: flex; */
        /*! flex-direction: column; */
        /*! align-content: center; */
        /*! justify-content: end; */
        padding-left: 15px;
        background-color: white;
        margin-left: 35px;
    }

    .nav-middle a.active {
        border-left-color: var(--active-blue);
    }

    .nav-middle a:hover lord-icon,
    .nav-middle a.active lord-icon {
        color: var(--active-blue);
    }

    /* Main Content Styles */
    .mainsection {
        background: #f4efe3;
        border-radius: 1rem;
        
        padding: 2rem;
        margin-top: 2rem;
    }
    .book-section{
    box-shadow: 0 2px 15px rgba(0,0,0,0.1);
    padding:2rem;
    border-radius: 1rem;
    background:#ffffff;
    
    }
    .book-section h1{
    font-family: 'Karla';
        font-size: 2 rem;
        font-weight: 300;
        color: #2c3e50;
    
    }

    .header-text h1 {
        font-family: 'Playfair Display', serif;
        font-size: 2.5rem;
        font-weight: 300;
        color: #2c3e50;
    }

    .header-text h3 {
        color: #7f8c8d;
        font-weight: 400;
    }

    /* Form Styles */
    form {
        background: #ffffff;
        /*! padding: 2rem; */
        border-radius: 1rem;
        margin: 2rem 0;
    }

    .form-group {
    display: flex;
    flex-wrap: wrap;
    gap: 1rem; 
}


    .form-group label {
    display: inline-flex;  /* Change to inline flex container */
    align-items: center;   /* Align checkbox and text vertically */
    margin-right: 1.5rem;  /* Space between category items */
    margin-bottom: 0.5rem; /* Vertical spacing if items wrap */
    white-space: nowrap;   /* Prevent text wrapping */
}


    .form-group input,
    .form-group select,
    .form-group textarea {
        width: 100%;
        padding: 0.8rem;
        border: 2px solid #ecf0f1;
        border-radius: 0.5rem;
       	background: #f4efe3;
    }
    
    .form-group input[type="checkbox"] {
    margin-right: 0.5rem; /* Space between checkbox and text */
    transform: translateY(1px); /* Optical alignment adjustment */
}
	.form-group > br {  /* Remove line breaks between categories */
    display: none;
}

    /* Table Styles */
    table {
        width: 100%;
        border-collapse: collapse;
        margin: 2rem 0;
        background: white;
    }

    th {
        background: #000;
        color: white;
        padding: 1rem;
    }

    td {
        padding: 1rem;
        border-bottom: 1px solid var(--border-color);
    }

    table img {
        max-width: 80px;
        height: auto;
        border-radius: 0.3rem;
    }

    /* Button Styles */
    button {
        padding: 0.6rem 1.2rem;
        border-radius: 0.5rem;
        cursor: pointer;
        transition: all 0.3s ease;
    }

    button[type="submit"] {
        background: #000;
        color: white;
        border: none;
    }

    button[type="submit"]:hover {
        opacity: 0.9;
    }

    /* Search & Pagination */
    .search-container {
        background: #fff;
        border-radius: 2rem;
        padding: 0.5rem 1rem;
        border: 2px solid var(--border-color);
        /*! margin-bottom: 2rem; */
    }

    .pagination a {
        color: var(--primary-green);
        border: 2px solid var(--border-color);
    }

    .current-page {
        background: var(--primary-green);
    }

    /* Messages */
    .message {
        padding: 1rem;
        border-radius: 0.5rem;
        margin: 1rem 0;
    }

    .success { background: #d4edda; color: #155724; }
    .error { background: #f8d7da; color: #721c24; }
	.toppart{
	display:flex;
	justify-content:space-between;
	min-width:500px
	}
	.search-container input{
	border:none;
	
	}
	#Categories{
	display:flex;
	
	}
    /* Responsive Design */
    @media (max-width: 768px) {
        .container {
            grid-template-columns: 1fr;
            padding: 1rem;
        }

        .sidebar {
            position: static;
            margin-bottom: 2rem;
        }

        .header-text h1 {
            font-size: 2rem;
        }
    }

	
		  
		
    </style>
</head>
<body>
    <div class="container">
    
    	<div class="sidebar">
    		<a href="<%= request.getContextPath() %>/" class="logo">
			  <img 
			    alt="logo" 
			    src="${pageContext.request.contextPath}/resources/images/yonder.png"
			    style="width: 10em; height: auto; display: block;"
			  >
			</a>

       		
            
           <nav class="nav-middle">
			    <ul>
			    	<li>
                          <a href="#" onclick="showSection('home')">
	                       <lord-icon src="${pageContext.request.contextPath}/resources/icons/wired-outline-63-home-hover-3d-roll.json"
					           trigger="hover" 
					           style="width:30px;height:30px">
					       </lord-icon>
	                      </a>
                        </li>
			        <li><a href="#books" onclick="showSection('books')">
	                       <lord-icon src="${pageContext.request.contextPath}/resources/icons/wired-outline-112-book-hover-flutter.json"
					           trigger="hover" 
					           style="width:30px;height:30px">
					       </lord-icon>
	                      </a></li>
			        <li><a href="#authors" onclick="showSection('authors')">
	                       <lord-icon src="${pageContext.request.contextPath}/resources/icons/wired-outline-269-avatar-female-hover-glance.json"
					           trigger="hover" 
					           style="width:30px;height:30px">
					       </lord-icon>
	                      </a></li>
			        <li><a href="#orders" onclick="showSection('orders')"><lord-icon src="${pageContext.request.contextPath}/resources//icons/wired-outline-139-basket-morph-fill.json"
					           trigger="hover" 
					           style="width:30px;height:30px">
					       </lord-icon></a></li>
			        <li><a href="#categories" onclick="showSection('categories')">
			        <lord-icon src="${pageContext.request.contextPath}/resources/icons/wired-outline-35-edit-hover-line.json"
					           trigger="hover" 
					           style="width:30px;height:30px">
					       </lord-icon>
			        </a></li>
			    </ul>
			</nav>
			
			<div class= "nav-end">
				<li>
                          <a href="#" id="profileTrigger">
	                       <lord-icon src="${pageContext.request.contextPath}/resources//icons/wired-outline-21-avatar-hover-looking-around.json"
					           trigger="loop" 
					           style="width:30px;height:30px">
					       </lord-icon>
	                      </a>
                        </li>
                        <li>
                          <a href="#" id="logoutTrigger">
	                       <lord-icon src="${pageContext.request.contextPath}/resources//icons/wired-outline-19-magnifier-zoom-search-hover-spin-2.json"
					           trigger="loop" 
					           delay="2000"
					           style="width:30px;height:30px">
					       </lord-icon>
	                      </a>
                        </li>
			
			</div>
        
       		 

        </div>
        <div class="mainsection">
	    <div class="toppart">
	        <div class="header-text">
	            <h1>Hi, Admin!</h1>
	            <h3>Let's take a look at your activity today</h3>
	        </div>
	        
	        <form class="search-form" action="searchbarmain">
	            <div class="search-container">
	                <i class="fa fa-search"></i>
	                <input type="search" placeholder="Search for health data" autofocus required>
	            </div>
	        </form>
	    </div>

        
        <div id="books" class="book-section" >
        
          <h1>Book Administration</h1>
            
            <%-- Display messages --%>
            <c:if test="${not empty message}">
                <div class="message success">${message}</div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="message error">${error}</div>
            </c:if>

            <%-- Add/Edit Form --%>
            <%-- Only show form to edit a book if `book` is not empty --%>
            
            
			<c:if test="${not empty book}">
			    <form action="AdminBookServlet" method="post" enctype="multipart/form-data">
			    	 
			        <input type="hidden" name="action" value="update" />
			        <input type="hidden" name="bookId" value="${book.bookId}" />
			
			        <div class="form-group">
			            <label>Title:</label>
			            <input type="text" name="title" value="${book.title}" required />
			        </div>
			
			          <div class="form-group">
				        <label>Cover Image URL:</label>
				        <input type="text" name="coverImageUrl" value="${book.coverImageUrl}" />
				    </div>
				    <div class="form-group">
				        <label>Or Upload Cover Image:</label>
				        <input type="file" name="coverImage" accept="image/*" style="border: 2px solid red;" />

				    </div>
				
				   
			
			        <div class="form-group">
			            <label>Price:</label>
			            <input type="number" step="0.01" name="price" value="${book.price}" required />
			        </div>
			
			        <div class="form-group">
			            <label>Description:</label>
			            <textarea name="description">${book.description}</textarea>
			        </div>
			
			        <div class="form-group">
			            <label>ISBN:</label>
			            <input type="text" name="isbn" value="${book.isbn}" required />
			        </div>
			
			        <div class="form-group">
			            <label>Publication Date:</label>
			            <input type="date" name="publicationDate" 
			                   value="<fmt:formatDate value='${book.publicationDate}' pattern='yyyy-MM-dd' />" />
			        </div>
			
			        <div class="form-group">
			            <label>Stock Quantity:</label>
			            <input type="number" name="stockQuantity" value="${book.stockQuantity}" required />
			        </div>
			
			        <div class="form-group" id="Categories">
			            <label>Select Categories:</label><br>
			            <c:forEach var="category" items="${categories}">
			                <c:set var="isChecked" value="false" />
			                <c:if test="${book.categories != null}">
			                    <c:forEach var="cat" items="${book.categories}">
			                        <c:if test="${cat.categoryId == category.categoryId}">
			                            <c:set var="isChecked" value="true" />
			                        </c:if>
			                    </c:forEach>
			                </c:if>
			
			                <label>
			                    <input type="checkbox" name="categoryIds" value="${category.categoryId}"
			                           <c:if test="${isChecked}">checked</c:if> />
			                    ${category.categoryName}
			                </label><br>
			            </c:forEach>
			        </div>
			        
			        <div class="form-group">
					    <label for="authorSelect">Select Authors:</label>
					    <select id="authorSelect" name="authorIds" multiple="multiple" class="form-control select2">
					        <c:forEach var="author" items="${authors}">
					            <c:set var="isSelected" value="false" />
					            <c:if test="${book.authors != null}">
					                <c:forEach var="aut" items="${book.authors}">
					                    <c:if test="${aut.authorId == author.authorId}">
					                        <c:set var="isSelected" value="true" />
					                    </c:if>
					                </c:forEach>
					            </c:if>
					            <option value="${author.authorId}" <c:if test="${isSelected}">selected</c:if>>
					                ${author.name}
					            </option>
					        </c:forEach>
					    </select>
					</div>


			
			        <button type="submit">Update Book</button>
			    </form>
			</c:if>
			
			<%-- Show Add Book form if `book` is empty or not being edited --%>
			<c:if test="${empty book}">
			    <form action="AdminBookServlet" method="post" enctype="multipart/form-data">
			        <input type="hidden" name="action" value="add" />
			
			        <div class="form-group">
			            <label>Title:</label>
			            <input type="text" name="title" required />
			        </div>
			
			        <div class="form-group">
			            <label>Cover Image URL:</label>
			            <input type="text" name="coverImageUrl" />
			        </div>
			        <div class="form-group">
				        <label>Or Upload Cover Image:</label>
				        <input type="file" name="coverImage" accept="image/*"  />

				    </div>
			
			        <div class="form-group">
			            <label>Price:</label>
			            <input type="number" step="0.01" name="price" required />
			        </div>
			
			        <div class="form-group">
			            <label>Description:</label>
			            <textarea name="description"></textarea>
			        </div>
			
			        <div class="form-group">
			            <label>ISBN:</label>
			            <input type="text" name="isbn" required />
			        </div>
			
			        <div class="form-group">
			            <label>Publication Date:</label>
			            <input type="date" name="publicationDate" />
			        </div>
			
			        <div class="form-group">
			            <label>Stock Quantity:</label>
			            <input type="number" name="stockQuantity" required />
			        </div>
			
			        <div class="form-group">
			            <label>Select Categories:</label><br>
			            <c:forEach var="category" items="${categories}">
			                <label>
			                    <input type="checkbox" name="categoryIds" value="${category.categoryId}" />
			                    ${category.categoryName}
			                </label><br>
			            </c:forEach>
			        </div>
			        <div class="form-group">
					    <label for="authorSelect">Select Authors:</label>
					    <select id="authorSelect" name="authorIds" multiple="multiple" class="form-control select2">
					        <c:forEach var="author" items="${authors}">
					            <option value="${author.authorId}">${author.name}</option>
					        </c:forEach>
					    </select>
					</div>
			        
			
			        <button type="submit">Add Book</button>
			    </form>
			</c:if>
			
			
			<%-- Search Form --%>
			
			<form action="AdminBookServlet" method="get" class="search-form">
			    <input type="text" name="search" placeholder="Search by ID, Title or ISBN" 
			           value="${param.search}">
			    <button type="submit">Search</button>
			    <c:if test="${not empty param.search}">
			        <a href="AdminBookServlet" class="clear-search">Clear Search</a>
			    </c:if>
			</form>

            

            <%-- Books List --%>
            <table>
                <tr>
                    <th>ID</th>
                    <th>Title</th>
                    <th>Price</th>
                    <th>ISBN</th>
                    <th>Stock</th>
                    <th>Cover</th>
                    <th>Actions</th>
                </tr>
                <c:forEach items="${books}" var="book">
                    <tr>
                        <td>${book.bookId}</td>
                        <td>${book.title}</td>
                        <td>$${book.price}</td>
                        <td>${book.isbn}</td>
                        <td>${book.stockQuantity}</td>
                        <td><img src="<c:url value='${book.coverImageUrl}' />" alt="Book Cover" /></td>
                        <td>
                            <form action="AdminBookServlet" method="post" style="display:inline;">
							    <input type="hidden" name="action" value="delete" />
							    <input type="hidden" name="bookId" value="${book.bookId}" />
							    <button type="submit" onclick="return confirm('Are you sure?')">Delete</button>
							</form>
							<form action="AdminBookServlet" method="get" style="display:inline;">
							    <input type="hidden" name="action" value="edit" />
							    <input type="hidden" name="bookId" value="${book.bookId}" />
							    <button type="submit">Edit</button>
							</form>

					

                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty books}">
                    <tr><td colspan="7">No books found.</td></tr>
                </c:if>
            </table>
            <%-- Pagination --%>
			<div class="pagination">
			    <c:if test="${currentPage > 1}">
			        <a href="AdminBookServlet?page=${currentPage - 1}&size=${pageSize}&search=${param.search}">Previous</a>
			    </c:if>
			
			    <c:forEach begin="1" end="${totalPages}" var="i">
			        <c:choose>
			            <c:when test="${currentPage eq i}">
			                <span class="current-page">${i}</span>
			            </c:when>
			            <c:otherwise>
			                <a href="AdminBookServlet?page=${i}&size=${pageSize}&search=${param.search}">${i}</a>
			            </c:otherwise>
			        </c:choose>
			    </c:forEach>
			
			    <c:if test="${currentPage lt totalPages}">
			        <a href="AdminBookServlet?page=${currentPage + 1}&size=${pageSize}&search=${param.search}">Next</a>
			    </c:if>
			</div>
			
			<%-- Items per page selector --%>
			<div class="page-size">
			    <form action="AdminBookServlet" method="get">
			        <input type="hidden" name="search" value="${param.search}">
			        Items per page: 
			        <select name="size" onchange="this.form.submit()">
			            <option value="5" ${pageSize == 5 ? 'selected' : ''}>5</option>
			            <option value="10" ${pageSize == 10 ? 'selected' : ''}>10</option>
			            <option value="20" ${pageSize == 20 ? 'selected' : ''}>20</option>
			        </select>
			    </form>
			</div>
            
        </div>
        
        <%-- <div id="authors" class="admin-section" style="display:none;">
		    <h2>Author Management</h2>
		    <form action="AdminAuthorServlet" method="post">
		        <div class="form-group">
		            <label>Name:</label>
		            <input type="text" name="name" required />
		        </div>
		        <div class="form-group">
		            <label>Bio:</label>
		            <textarea name="bio"></textarea>
		        </div>
		        <button type="submit">Add Author</button>
		    </form>
		    <!-- List of Authors -->
		    <h3>Existing Authors</h3>
		    <table>
		        <tr>
		            <th>Name</th>
		            <th>Bio</th>
		            <th>Action</th>
		        </tr>
		        <c:forEach var="author" items="${authors}">
		            <tr>
		                <td>${author.name}</td>
		                <td>${author.bio}</td>
		                <td><a href="EditAuthorServlet?authorId=${author.id}">Edit</a></td>
		            </tr>
		        </c:forEach>
		    </table>
		</div> --%>
        
        </div>
        
        

        </div>
    
        
          
    
    <script>
        function showSection(sectionId) {
            document.querySelectorAll('.card').forEach(section => {
                section.style.display = 'none';
            });
            document.getElementById(sectionId).style.display = 'block';
        }

        function previewBookImage(input) {
            const preview = document.getElementById('bookPreview');
            if (input.files && input.files[0]) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    preview.src = e.target.result;
                    preview.style.display = 'block';
                }
                reader.readAsDataURL(input.files[0]);
            }
        }
        function showRelatedBooksModal() {
            document.getElementById('relatedBooksModal').style.display = 'flex';
        }

        function closeModal() {
            document.getElementById('relatedBooksModal').style.display = 'none';
        }

        function saveRelatedBooks() {
            // Handle saving related books
            closeModal();
        }

        // Update showSection function
        function showSection(sectionId) {
            document.querySelectorAll('.card').forEach(section => {
                section.style.display = 'none';
            });
            document.getElementById(sectionId).style.display = 'block';
        }

        // Initialize with Books section
        showSection('books');
        
        
        let currentTheme = 0;
        let lottieAnimation;

        function updateLottieColor(color) {
          const svg = document.querySelector('#logo-animation svg');
          if (svg) {
            svg.querySelectorAll('[fill]').forEach(el => {
              const fill = el.getAttribute('fill');
              if (fill && fill !== 'none' && fill !== '#ffffff') {
                el.setAttribute('fill', color);
              }
            });
            svg.querySelectorAll('[stroke]').forEach(el => {
              el.setAttribute('stroke', color);
            });
          }
        }

    </script>
    <script>
    $(document).ready(function() {
        // Initialize Select2
        $('#authorSelect').select2({
            placeholder: 'Select Authors', // Placeholder text
            allowClear: true // Option to clear selection
        	});
    	});
    
    
    
	</script>	
	<script >
	
	let currentTheme = 0;
    let lottieAnimation;

    function updateLottieColor(color) {
      const svg = document.querySelector('#logo-animation svg');
      if (svg) {
        svg.querySelectorAll('[fill]').forEach(el => {
          const fill = el.getAttribute('fill');
          if (fill && fill !== 'none' && fill !== '#ffffff') {
            el.setAttribute('fill', color);
          }
        });
        svg.querySelectorAll('[stroke]').forEach(el => {
          el.setAttribute('stroke', color);
        });
      }
    }
	
	</script>
	
    
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
</body>
</html>