<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
@font-face {
    font-family: 'Karla'; 
    src: url(${pageContext.request.contextPath}/resources/fonts/Karla-VariableFont_wght.ttf);
    font-weight: 300 300;
}

.main-footer {
  background: #f8f8f8;
  padding: 0px;
  font-family: Karla, sans-serif;
  border:2px #FFFFFF:
}

.footer-top {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 40px; /* Increased from 30px */
  margin-bottom: 0px;
  border-bottom: 1px solid #ddd;
  padding: 40px 0; /* Increased padding for height */
  background-color: #E8DFC9;
  color: #000000;
}

.footer-column {
  text-align: center;
  padding: 20px; /* Added padding to make each column more spacious */
}

.footer-heading {
  font-size: 1rem; /* Slightly increased from 1.1rem */
  margin-bottom: 20px; /* More spacing */
  color: #000000;
  text-transform: uppercase;
  letter-spacing: 1px;
}

.footer-text {
  font-size: 0.8rem; /* Increased from 0.7rem */
  color: #666;
  line-height: 1.7; /* More line spacing */
  margin: 0 auto;
  max-width: 250px;
}

.footer-bottom {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
  gap: 0px; /* Increased from 30px */
  padding: 40px 0; /* Added padding for space */
  background-color: #000000;
  color: #F4EFE3;
  justify-items:space-around;
}

.footer-section {
  text-align: center;
  padding: 20px;
}

.footer-subheading {
  font-size: 1rem; /* Increased slightly */
  margin-bottom: 20px; /* More spacing */
  color: #FFFFFF;
  text-transform: uppercase;
}

.footer-links {
  list-style: none;
  padding: 0;
  margin: 0 auto;
}

.footer-links li {
  margin-bottom: 12px; /* More breathing room between links */
}

.footer-links a {
  color: #bbb;
  text-decoration: none;
  font-size: 1rem; /* Up from 0.9rem */
  transition: color 0.3s ease;
}

.footer-links a:hover {
  color: #fff;
}

.footer-copyright {
  text-align: center;
  padding: 25px 0; /* More space */
  border-top: 1px solid #ddd;
  color: #666;
  font-size: 0.9rem; /* Slightly larger */
}

/* Responsive Styles */
@media (max-width: 768px) {
  .footer-top,
  .footer-bottom {
    grid-template-columns: 1fr;
    gap: 40px;
  }

  .footer-column,
  .footer-section {
    text-align: center;
    padding: 15px 10px;
  }

  .footer-heading,
  .footer-subheading {
    margin-bottom: 15px;
  }

  .footer-text {
    font-size: 0.9rem;
  }
}


</style>
</head>
<body>
	<footer class="main-footer">
  <div class="footer-top">
    <div class="footer-column">
      <h3 class="footer-heading">FREE DELIVERY</h3>
      <p class="footer-text">Delivery within 48 hours, free from 6% of purchase.</p>
    </div>
    
    <div class="footer-column">
      <h3 class="footer-heading">RICH SAMPLING</h3>
      <p class="footer-text">5-10 samples and miniatures in each sequence. It was chosen to measure.</p>
    </div>
    
    <div class="footer-column">
      <h3 class="footer-heading">CONTACT US</h3>
      <p class="footer-text">Consultation@yonder.com<br>+977 98629393628</p>
    </div>
    
    <div class="footer-column">
      <h3 class="footer-heading">OUR GIFT</h3>
      <p class="footer-text">Free book Available for all orders over Rs.5000</p>
    </div>
  </div>

  <div class="footer-bottom">
    <div class="footer-section">
      <h4 class="footer-subheading">HELP</h4>
      <ul class="footer-links">
        <li><a href="#">Payment</a></li>
        <li><a href="#">Delivery</a></li>
        <li><a href="#">Return of goods</a></li>
        <li><a href="#">Gift certificates</a></li>
      </ul>
    </div>

    <div class="footer-section">
      <h4 class="footer-subheading">INFORMATION</h4>
      <ul class="footer-links">
        <li><a href="#">Loyalty system</a></li>
        <li><a href="#">Privacy policy</a></li>
        <li><a href="#">Question answer</a></li>
      </ul>
    </div>

    <div class="footer-section">
      <h4 class="footer-subheading">SECTIONS</h4>
      <ul class="footer-links">
        <li><a href="#">Catalog</a></li>
        <li><a href="#">New arrivals</a></li>
        <li><a href="#">Popular</a></li>
      </ul>
    </div>

    <div class="footer-section">
      <h4 class="footer-subheading">SOCIAL NETWORK</h4>
      <ul class="footer-links">
        <li><a href="#">Instagram</a></li>
        <li><a href="#">Twitter</a></li>
        <li><a href="#">Facebook</a></li>
      </ul>
    </div>
  </div>

  
</footer>
</body>
</html>