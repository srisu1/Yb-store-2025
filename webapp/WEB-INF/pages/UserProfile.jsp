<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Profile</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/modal.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        @font-face {
            font-family: 'Playfair Display'; 
            src: url(fonts/PlayfairDisplay-VariableFont_wght.ttf);
            font-weight: 100 900;
            font-display: swap;
        }
        
        @font-face {
    font-family: 'Karla'; 
    src: url(fonts/Karla-VariableFont_wght.ttf);
    font-weight: 500 500;
  }
  
  

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            
        }

        body {
            margin: 1rem;
            background-color: #F3EFE4;
        }

        .Header {
            background-color: #F4EFE3 !important;
        }

        .profile-container {
            max-width: 1200px;
            margin: 0 auto;
            background: white;
            border-radius: 10px;
            background-color: #F4EFE3;
            padding: 2rem;
        }

        .profile-main-content {
            display: flex;
            gap: 3rem;
            flex-wrap: wrap;
        }

        .profile-left {
            flex: 1;
            min-width: 300px;
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 2rem;
        }

        .profile-right {
            flex: 2;
            min-width: 300px;
        }

        .profile-header {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .profile-pic-container {
            position: relative;
            width: 200px;
            height: 200px;
            border-radius: 50%;
            cursor: pointer;
            overflow: hidden;
            transition: all 0.3s ease;
            border: 3px solid var(--secondary-color);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            background-color:#E8DFC9;
        }

        .profile-pic {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .profile-overlay {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            opacity: 0;
            transition: opacity 0.3s ease;
            z-index: 1;
            backdrop-filter: blur(2px);
        }

        .profile-pic-container:hover .profile-overlay {
            opacity: 1;
        }

        .upload-icon {
            color: white;
            font-size: 2rem;
            margin-bottom: 10px;
        }

        .upload-instruction {
            color: white;
            font-size: 1rem;
            text-align: center;
            font-family: Karla;
            padding: 0 15px;
        }

        .profile-info {
            text-align: center;
        }

        .profile-info h1 {
            font-family: 'Playfair Display';
            font-size: 2.5rem;
            color: #2A2A2A;
            margin-bottom: 0.5rem;
            
        }

        .profile-info p {
            font-family: Karla;
            color: #666;
            font-size: 1.1rem;
        }

        .upload-btn {
            position: absolute;
            bottom: 0;
            right: 0;
            width: 35px;
            height: 35px;
            opacity: 0;
            z-index: 2;
        }

        /* Existing form styles */
        .section-title {
            color: var(--primary-color);
            margin: 1.5rem 0;
            padding-bottom: 0.5rem;
            border-bottom: 2px solid #eee;
            font-family: Playfair Display;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
           
            font-weight: 500;
            
        }
        .form-group h1{
        font-family:Playfair Display;
         margin-bottom: 0.5rem;
          color:#808080;
           font-weight: bold;
        
        }
         .form-group p{
        font-family:Playfair Display;
        color:#808080;
        font-weight: bold;
         margin-bottom: 2.5rem;
        
        }

        .form-control {
            width: 100%;
            padding: 0.75rem;
            border: 2px solid black !important;
            border-radius: 6px;
            font-size: 1rem;
            background-color:#F4EFE3;
            
        }
        
        
       

        .address-section {
            margin-top: 2rem;
            padding-top: 2rem;
            border-top: 2px solid #eee;
        }

        .address-card {
            background: #f8f9fa;
            padding: 1.5rem;
            border-radius: 8px;
            margin: 1rem 0;
            position: relative;
        }

        .default-address {
            border: 2px solid var(--secondary-color);
        }

        .address-actions {
            margin-top: 1rem;
            display: flex;
            gap: 1rem;
        }

        .logout-container {
            text-align: center;
            margin-top: 2rem;
            padding-top: 2rem;
            border-top: 2px solid #eee;
        }

        /* Button styles */
        button {
            --button_radius: 0.75em;
            --button_color: #E8DFC9;
            --button_outline_color: #000000;
            font-size: 17px;
            font-weight: bold;
            border: none;
            cursor: pointer;
            border-radius: var(--button_radius);
            background: var(--button_outline_color);
        }

        .button_top {
            display: block;
            box-sizing: border-box;
            border: 2px solid var(--button_outline_color);
            border-radius: var(--button_radius);
            padding: 0.75em 1.5em;
            background: var(--button_color);
            color: var(--button_outline_color);
            transform: translateY(-0.2em);
            transition: transform 0.1s ease;
        }

        button:hover .button_top {
            transform: translateY(-0.33em);
        }

        button:active .button_top {
            transform: translateY(0);
        }

        @media (max-width: 768px) {
            .profile-main-content {
                flex-direction: column;
                gap: 2rem;
            }
            
            .profile-left {
                order: 1;
                margin-bottom: 2rem;
            }
            
            .profile-right {
                order: 2;
            }
            
            .profile-pic-container {
                width: 150px;
                height: 150px;
            }
        }
        
        
.genre-grid {
        display: flex;
        flex-wrap: wrap;
        gap: 8px;
    }

    .genre-item {
        padding: 8px 12px;
        background-color: #E8DFC9;
        border-radius: 12px;
        cursor: pointer;
        transition: background-color 0.2s ease;
        font-size: 14px;
        color:#808080;
    }

    .genre-item.selected {
      
        font-weight: bold;
    }
	.section-title{
	font-family:Playfair Display;
	}
	
	
	
	.address-actions-header {
            margin-bottom: 1rem;
        }
        
        
        
        .remove-btn {
            background: none;
            border: none;
            cursor: pointer;
            padding: 0;
            color: #000000;
            font-size: 1.2rem;
        }
        
        .remove-btn:hover {
            color: #00000;
        }
        
        #addAddressForm {
            display: none;
            margin-top: 1rem;
        }
        
        /* Adjust address card positioning */
        .address-card {
            position: relative;
            padding-right: 2.5rem;
        }
        
        .address-actions {
            position: absolute;
            top: 0.5rem;
            right: 0.5rem;
        }

		.address-actions-header{
		background-color: #F3EFE4;
		
		}


        
        
    </style>
</head>
<body>
    <jsp:include page="/includes/HeaderOtherPages.jsp" />
    <div class="profile-container">
        <div class="profile-main-content">
            <!-- Left Column -->
            <div class="profile-left">
                <div class="profile-header">
                    <div class="profile-pic-container">
                        <div class="profile-overlay">
                            <i class="fa-solid fa-arrow-up-from-bracket upload-icon"></i>
                            <span class="upload-instruction">Upload Profile Picture</span>
                        </div>
                        <img src="${pageContext.request.contextPath}/userImage?id=${user.userId}" 
                            class="profile-pic" 
                            id="profilePreview"
                            onerror="this.src='data:image/svg+xml;utf8,<svg xmlns=\"http://www.w3.org/2000/svg\" viewBox=\"0 0 100 100\"><rect width=\"100%\" height=\"100%\" fill=\"%23cccccc\"/><text x=\"50%\" y=\"50%\" dominant-baseline=\"middle\" text-anchor=\"middle\" font-size=\"40\" fill=\"%23ffffff\">${fn:substring(user.fullName,0,1)}</text></svg>'">
                        <button type="button" class="upload-btn">
                            <span class="button_top"></span>
                            <input type="file" id="profileUpload" name="profileImage" accept="image/*" hidden>
                        </button>
                    </div>
                    <div class="profile-info">
                        <h1>${user.fullName}</h1>
                        <p>${user.email}</p>
                    </div>
                </div>
            </div>

            <!-- Right Column -->
            <div class="profile-right">
                <c:if test="${not empty errorMessage}">
                    <div class="error-message">${errorMessage}</div>
                </c:if>

                <form id="profileForm" action="${pageContext.request.contextPath}/updateProfile" 
                    method="POST" enctype="multipart/form-data">
                    
                    
                    
                    <div class="form-group">
                    
                    	<h1>Account Settings</h1>
                    	<p>Here, you can see and manage your info and activities.</p>
                    	
                        <label>FULL NAME</label>
                        <input type="text" class="form-control" name="fullName" value="${user.fullName}" required>
                    </div>

                    <div class="form-group">
                        <label>PHONE NUMBER</label>
                        <input type="tel" class="form-control" name="phone" value="${user.phoneNumber}" required>
                    </div>

                    <div class="form-group">
                        <label>LANGUAGE PREFERENCES</label>
                        <select class="form-control" name="languagePreference" required>
                            <option value="en" ${user.languagePreference == 'en' ? 'selected' : ''}>ENGLISH</option>
                            <option value="np" ${user.languagePreference == 'np' ? 'selected' : ''}>NEPALI</option>
                        </select>
                    </div>
                    <div class="section-title">Favourite Genre(s)</div>
						<div class="genre-grid">
						    <div class="genre-item selected">Fiction and Literature</div>
						    <div class="genre-item selected">Technology</div>
						    <div class="genre-item">Business and Investing</div>
						    <div class="genre-item">Arts & Photography</div>
						    <div class="genre-item">Foreign Languages</div>
						    <div class="genre-item">Kids and Teens</div>
						    <div class="genre-item selected">Manga and Graphic Novels</div>
						    <div class="genre-item">Travel</div>
						    <div class="genre-item">Learning and Reference</div>
						</div>
                    

                    <div class="section-title">Address Book</div>
                    <div class="address-section">
			        <div class="address-actions-header">
			            <button type="button" class="add-address-btn" id="showShippingForm">
			                <span class="button_top">Add Shipping Address</span>
			            </button>
			            <button type="button" class="add-address-btn" id="showDefaultForm">
			                <span class="button_top">Add Default Address</span>
			            </button>
			        </div>
			
			        <c:choose>
			            <c:when test="${not empty addresses}">
			                <c:forEach items="${addresses}" var="address">
			                    <div class="address-card ${addressPreferences.defaultAddressId == address.addressId ? 'default-address' : ''}">
			                        <div class="address-actions">
			                            <form action="${pageContext.request.contextPath}/deleteAddress" method="post">
			                                <input type="hidden" name="addressId" value="${address.addressId}">
			                                <button type="submit" class="remove-btn">
			                                    <i class="fa-solid fa-trash"></i>
			                                </button>
			                            </form>
			                        </div>
			                        <div class="address-display">
			                        
			                         <p>${address.addressLine}</p>
			                        <p>${address.city}, ${address.state} ${address.postalCode}</p>
			                        <p>${address.country}</p>
			                        
			                        </div>
			                       
			                    </div>
			                </c:forEach>
			            </c:when>
			            <c:otherwise>
			                <p>No addresses found.</p>
			            </c:otherwise>
			        </c:choose>
			
			        <!-- Add Address Form (hidden by default) -->
			        <div id="addAddressForm">
			            <div class="section-title">Add New Address</div>
			            <div class="form-group">
			                <label>Address Line</label>
			                <input type="text" name="addressLine" class="form-control" required>
			            </div>
                        <div class="form-group">
                            <label>City</label>
                            <input type="text" name="city" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label>State</label>
                            <input type="text" name="state" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label>Postal Code</label>
                            <input type="text" name="postalCode" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label>Country</label>
                            <input type="text" name="country" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label>
                                <input type="checkbox" name="setAsDefault"> Set as Default Address
                            </label>
                        </div>
                        <button type="submit" class="save-btn" value="saveAddress">
                            <span class="button_top">Save Address</span>
                        </button>
                    </div>

                    <button type="submit" class="save-btn" value="saveAll">
                        <span class="button_top">SAVE ALL CHANGES</span>
                    </button>
                </form>

                <div class="logout-container">
                    <a href="${pageContext.request.contextPath}/logout" class="logout-button">
                        <span class=" button_top">Logout</span>
                    </a>
                </div>
            </div>
        </div>
        
        <jsp:include page="/includes/modal.jsp" />
    </div>

    <script>
        document.getElementById('profileUpload').addEventListener('change', function(e) {
            const file = e.target.files[0];
            if (file) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    document.getElementById('profilePreview').src = e.target.result;
                }
                reader.readAsDataURL(file);
            }
        });

        document.getElementById('profileForm').addEventListener('submit', function(e) {
            e.preventDefault();
            const formData = new FormData(this);

            fetch('${pageContext.request.contextPath}/updateProfile', {
                method: 'POST',
                body: formData
            }).then(response => {
                if (response.ok) {
                    window.location.reload();
                } else {
                    response.text().then(text => {
                        alert('Error: ' + text);
                    });
                }
            }).catch(error => {
                console.error('Error:', error);
                alert('An error occurred while updating profile');
            });
        });

        // Make entire profile container clickable
        document.querySelector('.profile-pic-container').addEventListener('click', function(e) {
            if (!e.target.closest('.upload-btn')) {
                document.getElementById('profileUpload').click();
            }
        });
        
        
        
        document.querySelectorAll('.genre-item').forEach(item => {
            item.addEventListener('click', () => {
                item.classList.toggle('selected');
            });
        });
        
        
        
        
        
     // Show/hide address form
        document.getElementById('showShippingForm').addEventListener('click', function() {
            const form = document.getElementById('addAddressForm');
            form.style.display = 'block';
            document.getElementById('setAsDefault').checked = false;
        });

        document.getElementById('showDefaultForm').addEventListener('click', function() {
            const form = document.getElementById('addAddressForm');
            form.style.display = 'block';
            document.getElementById('setAsDefault').checked = true;
        });

        // Hide form when clicking save (assuming page reload)
        document.querySelector('button[value="saveAddress"]').addEventListener('click', function() {
            document.getElementById('addAddressForm').style.display = 'none';
        });
    </script>
    
    <script src="${pageContext.request.contextPath}/resources/js/modal.js" defer></script>
</body>
</html>