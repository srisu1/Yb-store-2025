<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
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
       

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family:Karla;
         
         .data-table th{
         color:#000000;
         
         }

        .dashboard-container {
            display: grid;
            grid-template-columns: 250px 1fr;
            min-height: 100vh;
            background:#F4EFE3;
            border:1px solid;
            border-radius:20px;
            margin:20px;
        }

        /* Sidebar Styles */
        .sidebar {
            background: #000000;
            color: white;
            padding: 20px;
            position: sticky;
            top: 0;
            height: 100vh;
            margin:20px;
            border-radius:20px;
        }

        .sidebar h2 {
            margin-bottom: 30px;
            padding-bottom: 15px;
            border-bottom: 1px solid rgba(255,255,255,0.1);
        }

        .sidebar-nav ul {
            list-style: none;
        }

        .sidebar-nav a {
            color: white;
            text-decoration: none;
            padding: 12px 15px;
            display: block;
            border-radius: 6px;
            margin: 8px 0;
            transition: all 0.3s ease;
        }

        .sidebar-nav a:hover {
            background: var(--secondary-color);
        }

        /* Main Content Styles */
        .main-content {
            padding: 30px;
             background:#F4EFE3;
             border-radius:inherit;
        }

        .section-title {
            margin-bottom: 25px;
            font-family:Karla;
            font-size: 1.8rem;
        }

        /* Card Layout */
        .card {
            background:#F4EFE3;
            border-radius: 10px;
            padding: 25px;
           
            margin-bottom: 30px;
        }

        /* Form Styles */
        .form-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: var(--primary-color);
            font-weight: 500;
        }

        .form-group input, 
        .form-group select,
        .form-group textarea,
        .form-group .file-upload {
            width: 80%;
            padding: 10px 15px;
            border: 2px solid black;
            border-radius: 8px;
            font-size: 1rem;
            transition: border-color 0.3s ease;
            background:#F4EFE3;
        }

        .form-group input:focus, 
        .form-group select:focus,
        .form-group textarea:focus {
            border-color: var(--secondary-color);
            outline: none;
        }

        /* Table Styles */
        .data-table-wrapper {
            overflow-x: auto;
            border:2px solid black;
            border-radius: 20px;
        }

        .data-table {
            width: 100%;
            border-collapse: collapse;
           	background:#F4EFE3;
            
            overflow: hidden;
            box-shadow: 0 2px 15px rgba(0,0,0,0.1);
        }

        .data-table th,
        .data-table td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid #eee;
        }

        .data-table th {
            background: var(--primary-color);
            color: white;
            font-weight: 600;
        }

        /* Buttons & Actions */
        .btn {
            padding: 8px 15px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            transition: all 0.3s ease;
            font-weight: 500;
        }

        .btn-primary {
            background: #000000;
            color: white;
        }

        .btn-danger {
            background: background: #F4EAC4;
            border:2px solid;
        }

        .btn-success {
            background: #263843;
            color: white;
        }

        /* Image Upload */
        .file-upload {
            position: relative;
            overflow: hidden;
        }

        .file-upload input[type="file"] {
            position: absolute;
            left: 0;
            top: 0;
            opacity: 0;
            cursor: pointer;
        }

        .preview-image {
            max-width: 150px;
            height: auto;
            margin-top: 10px;
            display: none;
        }

        /* Status Indicators */
        .status-indicator {
            display: inline-block;
            padding: 5px 12px;
            border-radius: 15px;
            font-size: 0.9rem;
        }

        .status-active {
            background: #d4edda;
            color: #155724;
        }

        .status-inactive {
            background: #f8d7da;
            color: #721c24;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .dashboard-container {
                grid-template-columns: 1fr;
            }

            .sidebar {
                height: auto;
                position: static;
            }

            .main-content {
                padding: 20px;
            }
            .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,0.5);
            justify-content: center;
            align-items: center;
        }
        
        .modal-content {
            background: white;
            padding: 20px;
            border-radius: 8px;
            max-width: 500px;
            width: 90%;
        }
        
        .multi-select {
            height: 150px;
            overflow-y: auto;
            border: 1px solid #ddd;
            padding: 10px;
            margin: 10px 0;
        }
        .logo {
		  display: flex;
		  align-items: center;
		}
		
		#logo-animation {
		  width: clamp(80px, 10vw, 180px);
		  height: auto;
		  aspect-ratio: 1/1;
		  
		 
		}
    </style>
</head>
<body>
    <div class="dashboard-container">
        <!-- Sidebar -->
        <nav class="sidebar">
        
       		 <a href="<%= request.getContextPath() %>/" class="logo">
          <lottie-player
            id="logo-animation"
            src="${pageContext.request.contextPath}/resources/icons/yonder.json"
            background="transparent"
            speed="1"
            style="width: clamp(80px, 10vw, 180px); height: auto; color:#000000;"
            autoplay>
          </lottie-player>
        </a>
       		
            <h2>Admin Dashboard</h2>
            <nav class="sidebar-nav">
                <ul>
                    <li><a href="#books" onclick="showSection('books')">Books</a></li>
                    <li><a href="#authors" onclick="showSection('authors')">Authors</a></li>
                    <li><a href="#orders" onclick="showSection('orders')">Orders</a></li>
                    <li><a href="#users" onclick="showSection('users')">Users</a></li>
                    <li><a href="#inventory" onclick="showSection('inventory')">Inventory</a></li>
                    <li><a href="#reviews" onclick="showSection('reviews')">Reviews</a></li>
                    <li><a href="#wishlists" onclick="showSection('wishlists')">Wishlists</a></li>
                    <li><a href="#discounts" onclick="showSection('discounts')">Discounts</a></li>
                    <li><a href="#categories" onclick="showSection('categories')">Categories</a></li>
                    <li><a href="#related-books" onclick="showSection('related-books')">Related Books</a></li>
                </ul>
            </nav>
        </nav>

        <!-- Main Content -->
        <main class="main-content">
            <!-- Books Section -->
            <section id="books" class="card">
                <h2 class="section-title">Books Management</h2>
                <form class="form-grid" enctype="multipart/form-data">
                 <div class="form-group">
                        <label>Title</label>
                        <input type="text" name="title" required>
                    </div>
                    <div class="form-group">
                        <label>Price</label>
                        <input type="number" step="0.01" name="price" required>
                    </div>
                    <div class="form-group">
                        <label>ISBN</label>
                        <input type="text" name="isbn" required>
                    </div>
                    <div class="form-group">
                        <label>Cover Image</label>
                        <div class="file-upload">
                            <input type="file" accept="image/*" name="cover" onchange="previewBookImage(this)">
                            <span>Choose File</span>
                        </div>
                        <img class="preview-image" id="bookPreview">
                    </div>
                    <div class="form-group">
                        <label>Publication Date</label>
                        <input type="date" name="pub_date" required>
                    </div>
                    <div class="form-group">
                        <label>Stock Quantity</label>
                        <input type="number" name="stock" required>
                    </div>
                    <div class="form-group">
                        <label>Description</label>
                        <textarea name="description" rows="3"></textarea>
                    </div>
                    <div class="form-group">
                        <label>Categories</label>
                        <div class="multi-select">
                            <label><input type="checkbox"> Science Fiction</label>
                            <label><input type="checkbox"> Fantasy</label>
                            <label><input type="checkbox"> Mystery</label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label>Related Books</label>
                        <div class="multi-select">
                            <label><input type="checkbox"> Book 1</label>
                            <label><input type="checkbox"> Book 2</label>
                        </div>
                    </div>
                    <div class="form-group">
                        <button type="submit" class="btn btn-primary">Add Book</button>
                    </div>
                </form>
                <div class="data-table-wrapper">
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>Cover</th>
                                <th>Title</th>
                                <th>Price</th>
                                <th>Stock</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td><img src="placeholder.jpg" class="preview-image"></td>
                                <td>Sample Book</td>
                                <td>$29.99</td>
                                <td>15</td>
                                <td>
                                    <button class="btn btn-primary">Edit</button>
                                    <button class="btn btn-danger">Delete</button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </section>

            <!-- Authors Section -->
            <section id="authors" class="card" style="display: none;">
                <h2 class="section-title">Authors Management</h2>
                <form class="form-grid">
                    <div class="form-group">
                        <label>Author Name</label>
                        <input type="text" required>
                    </div>
                    <div class="form-group">
                        <label>Email</label>
                        <input type="email" required>
                    </div>
                    <div class="form-group">
                        <label>Biography</label>
                        <textarea rows="3"></textarea>
                    </div>
                    <div class="form-group">
                        <button class="btn btn-primary">Add Author</button>
                    </div>
                </form>
                <div class="data-table-wrapper">
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>Name</th>
                                <th>Email</th>
                                <th>Books</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>J.K. Rowling</td>
                                <td>jk@example.com</td>
                                <td>12</td>
                                <td>
                                    <button class="btn btn-primary">Edit</button>
                                    <button class="btn btn-danger">Delete</button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </section>
			<!-- Categories Section -->
            <section id="categories" class="card" style="display: none;">
                <h2 class="section-title">Category Management</h2>
                <form class="form-grid">
                    <div class="form-group">
                        <label>Category Name</label>
                        <input type="text" required>
                    </div>
                    <div class="form-group">
                        <button class="btn btn-primary">Add Category</button>
                    </div>
                </form>
                
                <div class="data-table-wrapper">
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>Category ID</th>
                                <th>Category Name</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>1</td>
                                <td>Science Fiction</td>
                                <td>
                                    <button class="btn btn-primary">Edit</button>
                                    <button class="btn btn-danger">Delete</button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </section>

            <!-- Related Books Section -->
            <section id="related-books" class="card" style="display: none;">
                <h2 class="section-title">Related Books Management</h2>
                <div class="data-table-wrapper">
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>Main Book</th>
                                <th>Related Books</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>The Hobbit</td>
                                <td>Lord of the Rings</td>
                                <td>
                                    <button class="btn btn-primary" onclick="showRelatedBooksModal()">Edit</button>
                                    <button class="btn btn-danger">Delete</button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </section>
         
			
            <!-- Orders Section -->
            <section id="orders" class="card" style="display: none;">
                <h2 class="section-title">Orders Management</h2>
                <div class="form-grid">
                    <div class="form-group">
                        <select class="form-control">
                            <option>Order ID</option>
                            <option>Customer Name</option>
                            <option>Status</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <input type="text" placeholder="Search...">
                    </div>
                    <div class="form-group">
                        <button class="btn btn-primary">Search</button>
                    </div>
                </div>
                <div class="data-table-wrapper">
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>Order ID</th>
                                <th>Customer</th>
                                <th>Date</th>
                                <th>Amount</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>#1001</td>
                                <td>John Doe</td>
                                <td>2023-09-20</td>
                                <td>$49.99</td>
                                <td>
                                    <select class="form-control">
                                        <option>Pending</option>
                                        <option>Processing</option>
                                        <option>Completed</option>
                                    </select>
                                </td>
                                <td>
                                    <button class="btn btn-primary">Update</button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </section>

            <!-- Users Section -->
            <section id="users" class="card" style="display: none;">
                <h2 class="section-title">User Management</h2>
                <div class="data-table-wrapper">
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>Name</th>
                                <th>Email</th>
                                <th>Role</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>John Doe</td>
                                <td>john@example.com</td>
                                <td>
                                    <select class="form-control">
                                        <option>Admin</option>
                                        <option>Customer</option>
                                    </select>
                                </td>
                                <td>
                                    <span class="status-indicator status-active">Active</span>
                                </td>
                                <td>
                                    <button class="btn btn-danger">Disable</button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </section>

            <!-- Inventory Section -->
            <section id="inventory" class="card" style="display: none;">
                <h2 class="section-title">Inventory Management</h2>
                <div class="data-table-wrapper">
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>Book Title</th>
                                <th>Current Stock</th>
                                <th>Threshold</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>Sample Book</td>
                                <td>15</td>
                                <td>10</td>
                                <td>
                                    <span class="status-indicator status-active">In Stock</span>
                                </td>
                                <td>
                                    <button class="btn btn-primary">Restock</button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </section>

            <!-- Reviews Section -->
            <section id="reviews" class="card" style="display: none;">
                <h2 class="section-title">Reviews Management</h2>
                <div class="data-table-wrapper">
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>Book</th>
                                <th>User</th>
                                <th>Rating</th>
                                <th>Review</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>Sample Book</td>
                                <td>user@example.com</td>
                                <td>★★★★☆</td>
                                <td>Great book!</td>
                                <td>
                                    <select class="form-control">
                                        <option>Approved</option>
                                        <option>Pending</option>
                                    </select>
                                </td>
                                <td>
                                    <button class="btn btn-danger">Delete</button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </section>

            <!-- Wishlists Section -->
            <section id="wishlists" class="card" style="display: none;">
                <h2 class="section-title">Wishlist Management</h2>
                <div class="data-table-wrapper">
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>User</th>
                                <th>Items</th>
                                <th>Last Updated</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>user@example.com</td>
                                <td>5</td>
                                <td>2023-09-20</td>
                                <td>
                                    <button class="btn btn-primary">View</button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </section>

            <!-- Discounts Section -->
            <section id="discounts" class="card" style="display: none;">
                <h2 class="section-title">Discount Management</h2>
                <form class="form-grid">
                    <div class="form-group">
                        <label>Promo Code</label>
                        <input type="text" required>
                    </div>
                    <div class="form-group">
                        <label>Discount Type</label>
                        <select class="form-control">
                            <option>Percentage</option>
                            <option>Fixed Amount</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Value</label>
                        <input type="number" step="0.01" required>
                    </div>
                    <div class="form-group">
                        <label>Valid From</label>
                        <input type="datetime-local" required>
                    </div>
                    <div class="form-group">
                        <label>Valid Until</label>
                        <input type="datetime-local" required>
                    </div>
                    <div class="form-group">
                        <button class="btn btn-success">Create Discount</button>
                    </div>
                </form>
                <div class="data-table-wrapper">
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>Code</th>
                                <th>Type</th>
                                <th>Value</th>
                                <th>Validity</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>SUMMER23</td>
                                <td>Percentage</td>
                                <td>20%</td>
                                <td>2023-09-01 to 2023-09-30</td>
                                <td>
                                    <button class="btn btn-primary">Edit</button>
                                    <button class="btn btn-danger">Delete</button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </section>
        </main>
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
</body>
</html>