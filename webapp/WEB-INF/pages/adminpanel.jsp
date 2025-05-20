<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<!DOCTYPE html>
<html>
<head>
    <title>Admin Panel</title>
     <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin.css">
     
    <link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/css/select2.min.css" rel="stylesheet" />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/js/select2.min.js"></script>
    <script src="https://cdn.lordicon.com/lordicon.js"></script>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
	<script src="https://unpkg.com/@lottiefiles/lottie-player@latest/dist/lottie-player.js"></script>
	
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">
    
    
 
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
			        <li>
					  <a href="#people" onclick="showSection('people'); togglePeopleSection('author');">

					      <lord-icon src="${pageContext.request.contextPath}/resources/icons/wired-outline-269-avatar-female-hover-glance.json"
					           trigger="hover" 
					           style="width:30px;height:30px">
					      </lord-icon>
					  </a>
					</li>

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
        	<jsp:include page="admin_book.jsp" />
        	
        

            
        </div>
        
        <div id="people" class="people-section" style="display:none;">
	        <jsp:include page="admin_people.jsp"/>
	    </div>
	       
        
        </div>
        
        

        </div>
    
        
          
    
  	 <script src="${pageContext.request.contextPath}/resources/js/admin.js" defer></script>
    
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
</body>
</html>
