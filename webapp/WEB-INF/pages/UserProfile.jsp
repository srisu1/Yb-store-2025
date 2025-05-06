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
        
            <form id="profileForm" action="${pageContext.request.contextPath}/updateProfile" method="POST" enctype="multipart/form-data">
                <div class="profile-pic-container">
				    <div class="profile-overlay">
				        <i class="fa-solid fa-arrow-up-from-bracket upload-icon"></i>
				        <span class="upload-instruction">Upload Profile Picture</span>
				    </div>
				    <!-- Updated image tag -->
				    <img src="${user.profilePictureUrl}" 
				         class="profile-pic" 
				         id="profilePreview"
				         onerror="this.src='${pageContext.request.contextPath}/path_to_default_image.jpg'">
				    <input type="file" id="profileUpload" name="profileImage" accept="image/*" hidden>
				</div>

                    <div class="profile-info">
                        <h1>${user.fullName}</h1>
                        <p>${user.email}</p>
                    </div>
                </div>

                <!-- Right Column -->
                <div class="profile-right">
                    <c:if test="${not empty errorMessage}">
                        <div class="error-message">${errorMessage}</div>
                    </c:if>

                    <input type="hidden" name="selectedGenres" id="selectedGenres">
                    <div class="form-group">
                        <h1>Account Settings</h1>
                        <p>Manage your info and preferences.</p>
                        <label>FULL NAME</label>
                        <input type="text" name="fullName" value="${user.fullName}" required>
                    </div>

                    <div class="form-group">
                        <label>PHONE NUMBER</label>
                        <input type="tel" name="phone" value="${user.phoneNumber}" required>
                    </div>

                    <div class="form-group">
                        <label>LANGUAGE PREFERENCE</label>
                        <select name="languagePreference" required>
                            <option value="en" ${user.languagePreference == 'en' ? 'selected' : ''}>English</option>
                            <option value="np" ${user.languagePreference == 'np' ? 'selected' : ''}>Nepali</option>
                        </select>
                    </div>

                    <div class="section-title">Favourite Genre(s)</div>
                    <div class="genre-grid">
                        <c:forEach var="genre" items="${allGenres}">
                            <div class="genre-item ${user.genres.contains(genre) ? 'selected' : ''}">${genre}</div>
                        </c:forEach>
                    </div>

                    <div class="section-title">Address Book</div>
                    <div class="address-section">
                        <div class="address-actions-header">
                            <button type="button" id="showAddressForm">Add Address</button>
                        </div>

                        <c:choose>
                            <c:when test="${not empty addresses}">
                                <c:forEach items="${addresses}" var="address">
                                    <div class="address-card ${addressPreferences.defaultAddressId == address.addressId ? 'default-address' : ''}">
                                        <p>${address.addressLine}</p>
                                        <p>${address.city}, ${address.state} ${address.postalCode}</p>
                                        <p>${address.country}</p>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <p>No addresses found.</p>
                            </c:otherwise>
                        </c:choose>

                        <div id="addAddressForm" style="display: none;">
                            <div class="form-group"><label>Address Line</label><input type="text" name="addressLine"></div>
                            <div class="form-group"><label>City</label><input type="text" name="city"></div>
                            <div class="form-group"><label>State</label><input type="text" name="state"></div>
                            <div class="form-group"><label>Postal Code</label><input type="text" name="postalCode"></div>
                            <div class="form-group"><label>Country</label><input type="text" name="country"></div>
                            <div class="form-group"><label><input type="checkbox" name="setAsDefault"> Set as Default Address</label></div>
                        </div>
                    </div>

                    <div class="form-group">
                        <button type="submit" name="action" value="saveAll">Save All Changes</button>
                    </div>
                </div>
            </form>

            <div class="logout-container">
                <a href="${pageContext.request.contextPath}/logout" class="logout-button">Logout</a>
            </div>
        </div>
    </div>

    <jsp:include page="/includes/modal.jsp" />
</div>

<script>
    // Image Preview
    document.getElementById('profileUpload').addEventListener('change', function(e) {
        const file = e.target.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = function(e) {
                document.getElementById('profilePreview').src = e.target.result;
            };
            reader.readAsDataURL(file);
        }
    });

    // Click on image triggers file input
    document.querySelector('.profile-pic-container').addEventListener('click', () => {
        document.getElementById('profileUpload').click();
    });

    // Genre selection logic
    const genreItems = document.querySelectorAll('.genre-item');
    const selectedGenresInput = document.getElementById('selectedGenres');
    genreItems.forEach(item => {
        item.addEventListener('click', () => {
            item.classList.toggle('selected');
            updateSelectedGenres();
        });
    });

    function updateSelectedGenres() {
        const selected = [...document.querySelectorAll('.genre-item.selected')].map(item => item.textContent.trim());
        selectedGenresInput.value = selected.join(',');
    }

    // Show address form
    document.getElementById('showAddressForm').addEventListener('click', () => {
        document.getElementById('addAddressForm').style.display = 'block';
    });
</script>
</body>


</html>