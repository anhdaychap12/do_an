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





