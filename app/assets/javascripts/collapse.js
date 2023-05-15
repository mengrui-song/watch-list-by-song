console.log("collapse.js loaded");
const showCast = document.querySelector("#show-cast");
const showCrew = document.querySelector("#show-crew");

const cast = document.querySelector("#collapse-cast");
const crew = document.querySelector("#collapse-crew");

console.log('cast' + cast);
console.log(cast.classList);
function toggleCollapse(collapse, button) {
  collapse.classList.toggle("d-none");
  if (collapse.classList.contains("d-none")) {
    button.classList.remove("btn-primary");
    button.classList.add("btn-secondary");
  }　else {
    button.classList.add("btn-primary");
    button.classList.remove("btn-secondary");
  }
}
showCast.addEventListener("click", (e) => {
  e.preventDefault();
  toggleCollapse(cast, showCast);
})

showCrew.addEventListener("click", (e) => {
  e.preventDefault();
  toggleCollapse(crew, showCrew);
})