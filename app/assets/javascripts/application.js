//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .

// Add this script to toggle the visibility of the rejection form
document.addEventListener("DOMContentLoaded", function() {
  var rejectButton = document.querySelector('button[onclick]');
  var rejectionForm = document.getElementById('rejection-form');

  rejectButton.addEventListener('click', function() {
    rejectionForm.style.display = 'block';
  });
});
