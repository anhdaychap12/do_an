// Scroll
function scrollValue() {
    var nav = document.getElementById('navbar');
    var scroll = window.scrollY;
    if (scroll < 10) {
        nav.classList.remove('position');
    } else {
        nav.classList.add('position');
    }
}
window.addEventListener('scroll', scrollValue);

// search
const searchBtn = document.querySelector(".js-click");
const searchText = document.querySelector(".search-text");

searchBtn.addEventListener("click", function() {
    searchText.classList.toggle("Click");
})

function showToast() {
    var toast = document.getElementById("toast");
    toast.classList.add("show");
  
    setTimeout(function() {
      toast.classList.remove("show");
    }, 2000); // Hide the toast after 3 seconds (3000 milliseconds)
}












