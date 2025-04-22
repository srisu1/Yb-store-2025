const themes = [
  {
    navbarColor: "#F4EAC4",
    heroBgColor: "#F4EAC4",
    textColor: "#263843",
    image: "resources/images/Book3.png"
  },
  {
    navbarColor: "#181A4E",
    heroBgColor: "#181A4E",
    textColor: "#E5A7D9",
    image: "resources/images/Book2.png"
  },
  {
    navbarColor: "#15240C",
    heroBgColor: "#15240C",
    textColor: "#FFFFFF",
    image: "resources/images/Book1.png"
  }
];

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

function changeTheme() {
  const theme = themes[currentTheme];

  document.querySelector(".Header").style.backgroundColor = theme.navbarColor;
  document.querySelector(".Hero-Section").style.backgroundColor = theme.heroBgColor;
  document.getElementById("hero-img").src = theme.image;

  const textElements = [
    ...document.querySelectorAll(".Navbar-Options a, .Icons a"),
    document.getElementById("logo-animation"),
    ...document.querySelectorAll(".Hero-Text h1")
  ];
  textElements.forEach(el => {
    if (el) el.style.color = theme.textColor;
  });

  document.querySelectorAll("lord-icon").forEach(icon => {
    icon.setAttribute("colors", `primary:${theme.textColor},secondary:${theme.textColor}`);
  });

  const blobPath = document.querySelector(".blob-button path");
  if (blobPath) blobPath.style.stroke = theme.textColor;

  const blobText = document.querySelector(".blob-button .blob-text");
  if (blobText) blobText.style.color = theme.textColor;

  document.querySelectorAll(".Drop-Down-List-Container a").forEach(el => {
    el.style.color = theme.textColor;
  });

  const waveDivider = document.querySelector(".wave-divider");
  if (waveDivider) {
    waveDivider.querySelectorAll("path, g").forEach(el => {
      if (el.tagName === 'path') {
        el.setAttribute("fill", theme.heroBgColor);
      } else {
        el.style.fill = theme.heroBgColor;
      }
    });
  }

  setTimeout(() => updateLottieColor(theme.textColor), 300);

  currentTheme = (currentTheme + 1) % themes.length;
}

document.addEventListener('DOMContentLoaded', () => {
  // Smooth transitions
  const style = document.createElement('style');
  style.textContent = `
    .Header, .Hero-Section,
    .Navbar-Options a, .Icons a,
    #logo-animation, .Hero-Text h1,
    .blob-button path, .Drop-Down-List-Container,
    .wave-divider svg path, .wave-divider img,
    .blob-button .blob-text, .Drop-Down-List-Container a {
      transition: background-color 0.5s ease, color 0.5s ease, fill 0.5s ease, stroke 0.5s ease;
    }

    #hero-img {
      transition: opacity 0.5s ease;
    }
  `;
  document.head.appendChild(style);

  //  Load Lottie logo with correct relative path
  lottieAnimation = lottie.loadAnimation({
    container: document.getElementById('logo-animation'),
    renderer: 'svg',
    loop: false,
    autoplay: true,
    path: 'resources/icons/yonder.json' // <== Update path if different
  });

  lottieAnimation.addEventListener('DOMLoaded', () => {
    updateLottieColor(themes[currentTheme].textColor);
  });

  //  DROP DOWN HANDLING
  const dropdown = document.querySelector('.Books-Drop-Down-List');
  const trigger = dropdown.querySelector('a');
  const dropdownMenu = dropdown.querySelector('.Drop-Down-List-Container');
  let isClicked = false;
  let hoverTimeout = null;

  trigger.addEventListener('click', function (e) {
    e.preventDefault();
    isClicked = !dropdown.classList.contains('active');
    dropdown.classList.toggle('active', isClicked);
  });

  document.addEventListener('click', function (e) {
    if (!dropdown.contains(e.target)) {
      isClicked = false;
      dropdown.classList.remove('active');
    }
  });

  trigger.addEventListener('keydown', function (e) {
    if (e.key === 'Enter' || e.key === ' ') {
      e.preventDefault();
      isClicked = !dropdown.classList.contains('active');
      dropdown.classList.toggle('active', isClicked);
    }
  });

  if (!('ontouchstart' in window)) {
    dropdown.addEventListener('mouseenter', () => {
      clearTimeout(hoverTimeout);
      if (!isClicked) dropdown.classList.add('active');
    });

    dropdown.addEventListener('mouseleave', () => {
      hoverTimeout = setTimeout(() => {
        if (!isClicked) dropdown.classList.remove('active');
      }, 200);
    });

    dropdownMenu.addEventListener('mouseenter', () => {
      clearTimeout(hoverTimeout);
      dropdown.classList.add('active');
    });

    dropdownMenu.addEventListener('mouseleave', () => {
      hoverTimeout = setTimeout(() => {
        if (!isClicked) dropdown.classList.remove('active');
      }, 200);
    });
  }

  // Init first theme
  changeTheme();
  setInterval(changeTheme, 5000);
});