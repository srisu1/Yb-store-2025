<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Us - HELIO</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/modal.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    
    <style>
        /* ===== Base Styles ===== */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            background-color: #F4EFE3;
        }

        body {
            display: flex;
            flex-direction: column;
            min-height: 100vh;
            justify-content: center;
            padding-top: 20px;
        }

        /* ===== Typography ===== */
        @font-face {
            font-family: 'Apercu Pro'; 
            src: url(${pageContext.request.contextPath}/resources/fonts/apercu_bold_pro.otf);
            font-weight: 200 300;
        }

        h2 {
            font-size: 1em;
            white-space: nowrap;
              margin-top: 4em;
            padding: 50px 0;
          
        }
        

        /* ===== Main Layout ===== */
        .contact-container {
            display: flex;
            gap: 60px;
            width: 100%;
            padding: 0 50px; /* Added bottom padding */
            align-items: flex-end;
            min-height: 90vh; /* Ensure container height */
            bottom: 6em;
			position:relative ;
        }

        .image-container {
        border-radius: 94px;
        overflow: hidden;
        width: 50%;
        aspect-ratio: 1/1;
        position: relative;
        
    }

        .image-container img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            
        }

        /* ===== Content Section ===== */
        .content-container-main {
            flex: 1;
            display: flex;
            flex-direction: column;
            gap: 80px;
            
        }

        .content-container {
            display: flex;
            gap: 15em;
            margin-left: 8em;
            align-items: center;
            
        }

        /* ===== Form Styles ===== */
        .contact-form {
            font-family:'Apercu Pro';
        }

        .contact-form .form-group {
            margin: 0;
        }

        .contact-form input, 
        .contact-form textarea {
            border: none;
            outline: none;
            background: transparent;
            width: 100%;
            padding: 8px 0;
            font-size: 1em;
        }

        /* ===== Address Section ===== */
        .address-content {
            margin-bottom: 7em;
            font-family: 'Apercu Pro';
        }

        /* ===== Button Styles ===== */
        .send-button {
            background-color: #F4EFE3;
            padding: 15px 40px;
            border: none;
            font-family: 'Apercu Pro';
            cursor: pointer;
            margin-top: 20px;
        }

        button img {
            width: 20px;
            height: 20px;
            margin-right: 8px;
        }

        .get-in-touch {
            font-size: 8em;
            font-family: 'Apercu Pro';
            line-height: 1;
            white-space: nowrap;
            
        }

        /* ===== Responsive Design ===== */
        @media (max-width: 768px) {
            .contact-container {
                flex-direction: column;
            }
            
            .image-container {
                height: 400px;
                width: 100%;
            }
            
            .content-container {
                flex-direction: column;
                gap: 2em;
                margin-left: 0;
                padding: 0 20px;
            }
            
            .get-in-touch {
                font-size: 3em;
                text-align: center;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="/includes/HeaderOtherPages.jsp" />
    
    <div class="contact-container">
        <div class="image-container">
            <img src="${pageContext.request.contextPath}/resources/images/Yonderimg.png" alt="Contact visual">
        </div>

        <div class="content-container-main">
            <div class="content-container">
                <form class="contact-form">
                    <h2>SAY HELIO</h2>
                    <div class="form-group">
                        <input type="text" placeholder="Name">
                    </div>
                    <div class="form-group">
                        <input type="email" placeholder="Email address">
                    </div>
                    <div class="form-group">
                        <input type="text" placeholder="Position">
                    </div>
                    <div class="form-group">
                        <input type="text" placeholder="Company">
                    </div>
                    <div class="form-group">
                        <textarea placeholder="Message"></textarea>
                    </div>
                    <button type="submit" class="send-button">
                        <img src="${pageContext.request.contextPath}/resources/icons/arrow-turn-down-right.svg" alt="Arrow Icon">
                        Send
                    </button>
                </form>

                <div class="address-content">
                    <h2>ADDRESS</h2>
                    <p>Kungsgatan 55<br>
                    411 15 Gothenburg<br>
                    Sweden</p>
                </div>
            </div>

            <h1 class="get-in-touch">Get in touch</h1>
        </div>
    </div>

    <jsp:include page="/includes/modal.jsp" />
    <script src="${pageContext.request.contextPath}/resources/js/modal.js" defer></script>
</body>
</html>