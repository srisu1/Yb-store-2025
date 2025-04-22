/**
 * 
 */

const loginTrigger = document.getElementById('loginTrigger');
const loginOverlay = document.getElementById('loginOverlay');
const registerOverlay = document.getElementById('registerOverlay');
const closeBtns = document.querySelectorAll('.close-btn');
const showRegister = document.getElementById('showRegister');
const showLogin = document.getElementById('showLogin');
const searchTrigger = document.getElementById('searchTrigger');
const searchOverlay = document.getElementById('searchOverlay');
const cartTrigger = document.getElementById('cartTrigger');
const cartOverlay = document.getElementById('cartOverlay');

// Show Login Modal
loginTrigger.addEventListener('click', (e) => {
  e.preventDefault();
  
  if (isLoggedIn) {
    // Redirect to profile if logged in
    window.location.href = `${contextPath}/redirectToUserProfile`;
  } else {
    // Show login modal for guests
    document.body.classList.add('modal-open');
    loginOverlay.style.display = 'flex';
  }
});

// Show Register Modal
showRegister.addEventListener('click', (e) => {
  e.preventDefault();
  loginOverlay.style.display = 'none';
  registerOverlay.style.display = 'flex';
});

// Add to modal.js
document.querySelector('#registerOverlay form').addEventListener('submit', (e) => {
    const password = document.getElementById('password').value;
    const confirmPassword = document.getElementById('confirmPassword').value;
    
    if (password !== confirmPassword) {
        e.preventDefault();
        alert('Passwords do not match!');
    }
});

// Show Login Modal from Register
showLogin.addEventListener('click', (e) => {
  e.preventDefault();
  registerOverlay.style.display = 'none';
  loginOverlay.style.display = 'flex';
});

// Show Search Modal
searchTrigger.addEventListener('click', () => {
    document.body.classList.add('modal-open');
    searchOverlay.style.display = 'flex';
  });

// Show Cart Modal
cartTrigger.addEventListener('click', () => {
    document.body.classList.add('modal-open');
    cartOverlay.style.display = 'block';
  });

// Cart Functionality
document.querySelectorAll('.cart-item').forEach(item => {
    const quantityInput = item.querySelector('.quantity-input');
    const minusBtn = item.querySelector('.minus');
    const plusBtn = item.querySelector('.plus');
    const removeBtn = item.querySelector('.remove-btn');
    const checkbox = item.querySelector('input[type="checkbox"]');
  
    // Quantity Controls
    minusBtn.addEventListener('click', () => {
      if(quantityInput.value > 1) quantityInput.value--;
      updateTotals();
    });
  
    plusBtn.addEventListener('click', () => {
      quantityInput.value++;
      updateTotals();
    });
  
    quantityInput.addEventListener('change', updateTotals);
  
    // Remove Item
    removeBtn.addEventListener('click', () => {
      item.remove();
      updateTotals();
    });
  
    // Checkbox Toggle
    checkbox.addEventListener('change', updateTotals);
  });

  
  function updateTotals() {
    let total = 0;
    
    document.querySelectorAll('.cart-item').forEach(item => {
      if(item.querySelector('input[type="checkbox"]').checked) {
        const price = parseFloat(item.querySelector('.item-price').textContent.replace('Rs',''));
        const quantity = parseInt(item.querySelector('.quantity-input').value);
        total += price * quantity;
      }
    });
  
    document.querySelector('.total-amount').textContent = `${total.toFixed(2)}`;
  }
  
  // Initial calculation
  updateTotals();
  
  const urlParams = new URLSearchParams(window.location.search);
  if (urlParams.get("showLogin") === "true") {
    document.body.classList.add('modal-open');
    loginOverlay.style.display = 'flex';
  }


  // Update click outside handling
  [loginOverlay, registerOverlay, searchOverlay].forEach(overlay => {
    overlay.addEventListener('click', (e) => {
      if (e.target === overlay) closeModal();
    });
  });

// Close Modal function
function closeModal() {
  document.body.classList.remove('modal-open');
  loginOverlay.style.display = 'none';
  registerOverlay.style.display = 'none';
  searchOverlay.style.display = 'none';
  cartOverlay.style.display = 'none';
}

// Close modals on close button click
closeBtns.forEach(btn => {
  btn.addEventListener('click', closeModal);
});

// Close modals when clicking outside
[loginOverlay, registerOverlay].forEach(overlay => {
  overlay.addEventListener('click', (e) => {
    if (e.target === overlay) closeModal();
  });
});

// Close on ESC key
document.addEventListener('keydown', (e) => {
  if (e.key === 'Escape') closeModal();
});

document.addEventListener('DOMContentLoaded', () => {
  const urlParams = new URLSearchParams(window.location.search);
  if (urlParams.get("showLogin") === "true") {
    document.body.classList.add('modal-open');
    loginOverlay.style.display = 'flex';
  }
});
