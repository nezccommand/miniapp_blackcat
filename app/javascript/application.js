// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import * as bootstrap from "bootstrap"
//= require swiper/js/swiper.js
//= require swiper.js

document.addEventListener('DOMContentLoaded', function() {
  const retryButtons = document.querySelectorAll('.retry-button');
  retryButtons.forEach(button => {
    button.addEventListener('click', function() {
      window.location.href = '/';
    });
  });
});