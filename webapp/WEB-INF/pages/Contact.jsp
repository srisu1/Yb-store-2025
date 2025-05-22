<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Us</title>
    <style>
        :root {
            --primary-color: #2c3e50;
            --secondary-color: #3498db;
            --light-bg: #f8f9fa;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Arial', sans-serif;
        }

        body {
            background: var(--light-bg);
            min-height: 100vh;
            display: flex;
            align-items: center;
            padding: 2rem;
        }

        .contact-container {
            max-width: 1200px;
            margin: 0 auto;
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 15px rgba(0,0,0,0.1);
            padding: 3rem;
            display: grid;
            grid-template-columns: 1fr 2fr;
            gap: 4rem;
        }

        .contact-info {
            border-right: 2px solid #eee;
            padding-right: 3rem;
        }

        .contact-form {
            display: flex;
            flex-direction: column;
        }

        .section-title {
            font-size: 2rem;
            color: var(--primary-color);
            margin-bottom: 2rem;
            text-transform: uppercase;
            letter-spacing: 2px;
        }

        .address-group {
            margin-bottom: 2rem;
        }

        .address-group h3 {
            color: var(--primary-color);
            margin-bottom: 1rem;
            font-size: 1.2rem;
        }

        .address-group p {
            color: #666;
            line-height: 1.6;
            margin-bottom: 0.5rem;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            color: var(--primary-color);
            font-weight: 500;
        }

        .form-control {
            width: 100%;
            padding: 0.8rem;
            border: 2px solid #eee;
            border-radius: 6px;
            font-size: 1rem;
        }

        textarea.form-control {
            height: 120px;
            resize: vertical;
        }

        .submit-btn {
            background: var(--secondary-color);
            color: white;
            padding: 1rem 2rem;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 1.1rem;
            transition: background 0.3s ease;
        }

        .submit-btn:hover {
            background: #2878b5;
        }

        .get-in-touch {
            text-align: center;
            margin-top: 2rem;
            font-size: 1.5rem;
            color: var(--primary-color);
        }

        @media (max-width: 768px) {
            .contact-container {
                grid-template-columns: 1fr;
                padding: 2rem;
            }

            .contact-info {
                border-right: none;
                border-bottom: 2px solid #eee;
                padding-right: 0;
                padding-bottom: 2rem;
            }

            body {
                padding: 1rem;
            }
        }
    </style>
</head>
<body>
    <div class="contact-container">
        <div class="contact-info">
            <h2 class="section-title">Contact</h2>
            <p style="margin-bottom: 2rem; color: #666;">IMPGRESTPOPULO.COM</p>
            
            <div class="address-group">
                <h3>SAY HELIO</h3>
                <p>Kungsgatan 55</p>
                <p>41115 Gothenburg</p>
                <p>Sweden</p>
            </div>

            <div class="address-group">
                <h3>ADDRESS</h3>
                <p>Name</p>
                <p>Email address</p>
                <p>Position</p>
                <p>Company</p>
            </div>
        </div>

        <form class="contact-form">
            <h2 class="section-title">Message</h2>
            
            <div class="form-group">
                <label>Name</label>
                <input type="text" class="form-control" required>
            </div>

            <div class="form-group">
                <label>Email Address</label>
                <input type="email" class="form-control" required>
            </div>

            <div class="form-group">
                <label>Position</label>
                <input type="text" class="form-control">
            </div>

            <div class="form-group">
                <label>Company</label>
                <input type="text" class="form-control">
            </div>

            <div class="form-group">
                <label>Message</label>
                <textarea class="form-control" required></textarea>
            </div>

            <button type="submit" class="submit-btn">Send</button>
        </form>
    </div>

    <div class="get-in-touch">
        Get in touch
    </div>
</body>
</html>