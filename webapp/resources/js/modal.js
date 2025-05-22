


if (window.modalScriptLoaded) {
	console.log("Modal script already loaded, skipping.");
} else {
	window.modalScriptLoaded = true;

	document.addEventListener('DOMContentLoaded', function () {
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

		const isLoggedInText = document.getElementById('isLoggedIn')?.innerText || "false";
		const isLoggedIn = isLoggedInText.trim() === "true";

		if (loginTrigger && loginOverlay) {
			loginTrigger.addEventListener('click', (e) => {
				e.preventDefault();
				if (isLoggedIn) {
					window.location.href = `${contextPath}/redirectToUserProfile`;
				} else {
					document.body.classList.add('modal-open');
					loginOverlay.style.display = 'flex';
				}
			});
		}

		if (showRegister && loginOverlay && registerOverlay) {
			showRegister.addEventListener('click', (e) => {
				e.preventDefault();
				loginOverlay.style.display = 'none';
				registerOverlay.style.display = 'flex';
			});
		}

		const registerForm = document.querySelector('#registerOverlay form');
		if (registerForm) {
			registerForm.addEventListener('submit', (e) => {
				const password = document.getElementById('password')?.value;
				const confirmPassword = document.getElementById('confirmPassword')?.value;
				if (password !== confirmPassword) {
					e.preventDefault();
					alert('Passwords do not match!');
				}
			});
		}

		if (showLogin && registerOverlay && loginOverlay) {
			showLogin.addEventListener('click', (e) => {
				e.preventDefault();
				registerOverlay.style.display = 'none';
				loginOverlay.style.display = 'flex';
			});
		}

		if (searchTrigger && searchOverlay) {
			searchTrigger.addEventListener('click', () => {
				document.body.classList.add('modal-open');
				searchOverlay.style.display = 'flex';
			});
		}

		function resetSearchModal() {
			const resultsContainer = searchOverlay?.querySelector('.search-results');
			const inputField = searchOverlay?.querySelector('input[name="query"]');
			if (resultsContainer) resultsContainer.innerHTML = "";
			if (inputField) inputField.value = "";
		}

		const sessionHasSearchResults = document.getElementById('hasSearchResults')?.innerText === "true";
		if (sessionHasSearchResults && searchOverlay) {
			document.body.classList.add('modal-open');
			searchOverlay.style.display = 'flex';
		}

		if (cartTrigger && cartOverlay) {
			cartTrigger.addEventListener('click', (e) => {
				e.preventDefault();
				if (isLoggedIn) {
					document.body.classList.add('modal-open');
					cartOverlay.style.display = 'block';
				} else {
					alert("Please log in to view your cart.");
				}
			});
		}

		function updateTotals() {
			let total = 0;
			document.querySelectorAll('.cart-item').forEach(item => {
				const checkbox = item.querySelector('input[type="checkbox"]');
				const priceElement = item.querySelector('.item-price');
				const quantityInput = item.querySelector('.quantity-input');

				if (checkbox?.checked && priceElement && quantityInput) {
					const price = parseFloat(priceElement.textContent.replace('Rs', ''));
					const quantity = parseInt(quantityInput.value);
					if (!isNaN(price) && !isNaN(quantity)) {
						total += price * quantity;
					}
				}
			});
			const totalAmount = document.querySelector('.total-amount');
			if (totalAmount) totalAmount.textContent = `${total.toFixed(2)}`;
		}

		document.querySelectorAll('.cart-item').forEach(item => {
			const quantityInput = item.querySelector('.quantity-input');
			const minusBtn = item.querySelector('.minus');
			const plusBtn = item.querySelector('.plus');
			const removeBtn = item.querySelector('.remove-btn');
			const checkbox = item.querySelector('input[type="checkbox"]');

			if (minusBtn && quantityInput) {
				minusBtn.addEventListener('click', () => {
					if (quantityInput.value > 1) quantityInput.value--;
					updateTotals();
				});
			}

			if (plusBtn && quantityInput) {
				plusBtn.addEventListener('click', () => {
					quantityInput.value++;
					updateTotals();
				});
			}

			if (quantityInput) {
				quantityInput.addEventListener('change', updateTotals);
			}

			if (removeBtn) {
				removeBtn.addEventListener('click', () => {
					item.remove();
					updateTotals();
				});
			}

			if (checkbox) {
				checkbox.addEventListener('change', updateTotals);
			}
		});

		updateTotals();

		function closeModal() {
			document.body.classList.remove('modal-open');
			if (loginOverlay) loginOverlay.style.display = 'none';
			if (registerOverlay) registerOverlay.style.display = 'none';
			if (searchOverlay) {
				searchOverlay.style.display = 'none';
				resetSearchModal();
			}
			if (cartOverlay) cartOverlay.style.display = 'none';
		}

		closeBtns.forEach(btn => {
			btn.addEventListener('click', closeModal);
		});

		[loginOverlay, registerOverlay, searchOverlay, cartOverlay].forEach(overlay => {
			if (overlay) {
				overlay.addEventListener('click', (e) => {
					if (e.target === overlay) closeModal();
				});
			}
		});

		document.addEventListener('keydown', (e) => {
			if (e.key === 'Escape') closeModal();
		});

		const urlParams = new URLSearchParams(window.location.search);
		if (urlParams.get("showLogin") === "true" && loginOverlay) {
			document.body.classList.add('modal-open');
			loginOverlay.style.display = 'flex';
		}
	});
}
