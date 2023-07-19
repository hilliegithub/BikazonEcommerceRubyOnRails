document.addEventListener('DOMContentLoaded', function() {
    // Get the menu button element
    var menuButton = document.querySelector('.navbar-burger');

    // Get the target menu element
    var targetMenu = document.getElementById(menuButton.dataset.target);

    // Add a click event listener to the menu button
    menuButton.addEventListener('click', function() {
      // Toggle the 'is-active' class on the menu button
      menuButton.classList.toggle('is-active');

      // Toggle the 'is-active' class on the target menu
      targetMenu.classList.toggle('is-active');

      // Get the select element by its id
      const selectElement = document.getElementById("category");

      // Add padding of 5 pixels to the select element
      selectElement.style.padding = "5px";
    });
  });