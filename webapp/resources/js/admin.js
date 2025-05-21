/**
 * 
 */
// Show/hide different admin sections
document.addEventListener("DOMContentLoaded", function () {
    const hash = window.location.hash.substring(1) || 'books';
    showSection(hash);
});


function showSection(sectionId) {
    console.log('Attempting to show:', sectionId);
    window.history.replaceState(null, null, `#${sectionId}`);

    document.querySelectorAll('.section').forEach(section => {
        section.classList.remove('active');
    });

    const sectionToShow = document.getElementById(sectionId);
    if (sectionToShow) {
        sectionToShow.classList.add('active');
        if (sectionId === 'people') {
            togglePeopleSection('author');
        }
    }
}



// Preview book image before upload
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

// Show/hide related books modal
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

// Lottie color update
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

// On document ready
$(document).ready(function() {
    const initialSection = window.location.hash.substring(1) || 'books';
    showSection(initialSection); // Remove the extra showSection('books') below this
    
    $('#authorSelect').select2({
        placeholder: 'Select Authors',
        allowClear: true
    });
});

function togglePeopleSection(type) {
    const authorSection = document.getElementById("author-management");
    const userSection = document.getElementById("user-management");

    if (type === "author") {
        authorSection.style.display = "block";
        userSection.style.display = "none";
    } else {
        authorSection.style.display = "none";
        userSection.style.display = "block";
    }

    const buttons = document.querySelectorAll(".toggle-btn");
    buttons.forEach(btn => {
        btn.classList.remove("active");
        if (btn.dataset.type === type) {
            btn.classList.add("active");
        }
    });
}
