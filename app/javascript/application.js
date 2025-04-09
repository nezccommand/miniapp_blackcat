// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import * as bootstrap from "bootstrap"
//= require swiper/js/swiper.js
//= require swiper.js

document.addEventListener('DOMContentLoaded', function() {
  const retryButton = document.getElementById('retry-button');
  if (retryButton) {
    retryButton.addEventListener('click', function() {
      window.location.href = '/';
    });
  }
});

document.addEventListener('DOMContentLoaded', function() {
  const quizStartButton = document.querySelector('a[data-load="true"]');
  
  if (quizStartButton) {
    quizStartButton.addEventListener('click', function(event) {
      event.preventDefault();
      window.location.href = this.href;
      setTimeout(function() {
        location.reload();
      }, 1000);
    });
  }
});

document.addEventListener('DOMContentLoaded', function() {
  const quizStartButton = document.querySelector('a[data-reload="true"]');
  
  if (quizStartButton) {
    quizStartButton.addEventListener('click', function(event) {
      event.preventDefault();
      window.location.href = this.href;
      setTimeout(function() {
        location.reload();
      }, 1000);
    });
  }
});

document.addEventListener('DOMContentLoaded', function() {
  const quizStartButton = document.querySelector('a[data-rereload="true"]');
  
  if (quizStartButton) {
    quizStartButton.addEventListener('click', function(event) {
      event.preventDefault();
      window.location.href = this.href;
      setTimeout(function() {
        location.reload();
      }, 1000);
    });
  }
});

document.addEventListener('DOMContentLoaded', function() {
  const retryButton = document.getElementById('result-retry-button');
  retryButton.addEventListener('click', function() {
    window.location.href = '/';
  });
});

document.addEventListener('DOMContentLoaded', function() {
  const swiper = new Swiper('.swiper-container', {
    loop: true,
    autoplay: {
      delay: 3000,
    },
    slidesPerView: 2,
    slidesPerGroup: 1,
  });
});