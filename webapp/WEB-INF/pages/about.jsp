<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Meet the Team</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/modal.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            background-color: #F4EFE3;
        }

        @font-face {
            font-family: 'Apercu Pro'; 
            src:url(${pageContext.request.contextPath}/resources/fonts/apercu_bold_pro.otf);
            font-weight: 200 300;
        }

        body {
            display: flex;
            flex-direction: column;
            min-height: 100vh;
            justify-content: center;
            padding: 20px;
        }

        .team-container {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 40px;
            max-width: 1200px;
            margin: 0 auto;
        }

        .team-member {
            display: inline-flex;
            align-items: baseline;
            position: relative;
            line-height: 1;
        }

        .name-part {
            font-family: 'Apercu Pro';
            font-weight: 600;
            font-size: 10.8rem;
            white-space: nowrap;
            vertical-align: bottom;
            position: relative;
            z-index: 2;
        }

        .team-member a {
            display: inline-block;
            width: auto;
            height: 8.5rem; /* Increased from 6.5rem */
            margin: 0 -0.3em; /* Adjusted negative margin */
            vertical-align: bottom;
            position: relative;
            
        }

        .team-member img {
            height: 120%; /* Increased image size */
            width: auto;
            vertical-align: bottom;
            transform: translateY(0.1em); /* Adjusted alignment */
            margin: 0 -0.9em; /* Negative margin for tighter fit */
            bottom: -4em; /* Align with text baseline */
        }

        .team-member:hover img {
            transform: scale(1.05);
        }

        h5 {
            text-align: center;
            margin: 0 auto 40px;
            width: 100%;
            font-weight: 100;
            
        }
    </style>
</head>
<body>
	<jsp:include page="/includes/HeaderOtherPages.jsp" />
   <!--  <h5>Meet the team</h5> -->
    
    <div class="team-container">
        <!-- Sri su -->
        <div class="team-member">
            <span class="name-part">Sri</span>
            <a href="#">
                <img src="${pageContext.request.contextPath}/resources/images/Srisu.png" alt="Sri">
            </a>
            <span class="name-part">su</span>
        </div>

        <!-- Dars hana -->
        <div class="team-member">
            <span class="name-part">Dars</span>
            <a href="#">
                <img src="${pageContext.request.contextPath}/resources/images/Darshana.png" alt="Darshana">
            </a>
            <span class="name-part">hana</span>
        </div>

        <!-- Aas ean -->
        <div class="team-member">
            <span class="name-part">Aas</span>
            <a href="#">
                <img src="${pageContext.request.contextPath}/resources/images/Aasean.png" alt="Aasean">
            </a>
            <span class="name-part">ean</span>
        </div>
    </div>
    <jsp:include page="/includes/modal.jsp" />
    
    <script src="${pageContext.request.contextPath}/resources/js/modal.js" defer></script>
</body>
</html>