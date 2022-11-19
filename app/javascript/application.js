// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import "bootstrap"

const input = document.querySelector(".search-movie");
const display = document.querySelector(".display-fetched-movies");
const movies = [];

console.log("hello world");
console.log(input);

input.addEventListener("keyup", fetchMovie);

function createMovieInfo(movie) {
  const movieInfo = {
    title: movie.title,
    poster_url: `https://image.tmdb.org/t/p/w500${movie.poster_path}`,
    overview: movie.overview,
    rating: movie.vote_average
  }
  return movieInfo;
}

function generateCard(movie) {
  const movieInfo = createMovieInfo(movie);
  movies.push(movieInfo);
  const movieCard =
    `<div class="movie-card ${movieInfo["title"]}">
    <img src="${movie.poster_path ? movieInfo["poster_url"] : ''}" alt="${movieInfo["title"]}" class="movie-poster">
    <div class="movie-card-infos">
      <div>
        <h2 class="movie-card-rating movie-rating">${movieInfo["rating"]}</h2>
        <h2 class="movie-title">${movieInfo["title"]}</h2>
      </div>
    </div>
  </div>`
  display.insertAdjacentHTML("beforeend", movieCard);
}

function selectMovie() {
  const cards = document.querySelectorAll(".movie-card");
  for (let i = 0; i < cards.length; i++) {
    console.log(cards[i]);
    cards[i].addEventListener('click', function (e) {
      // e.target.alt
      console.log("inspect movies array");
      movies.forEach(movie => {
        if (movie["title"] === e.target.alt) {
          console.log(input.value);
          input.value = JSON.stringify(movie);
          // I want to post the movie to controller,but it doesn't work well...
          // const url = window.location.href
          // const xhr = new XMLHttpRequest();
          // xhr.open("POST", url, true);
          // xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded; charset=UTF-8");
          // xhr.send(JSON.stringify(movie));
        }
      })
    }, false);
  }
}

function fetchMovie(e) {
  while (display.firstChild) {
    display.removeChild(display.firstChild);
  }
  const url = `https://api.themoviedb.org/3/search/movie?api_key=b04a4d29fa7cbdec4d7960abf964d46f&language=en-US&query=${input.value}&page=1&include_adult=false`
  fetch(url)
    .then((response) => response.json())
    .then((data) =>
      data.results.forEach(generateCard, this.movie)
    )
    .then(selectMovie)
}
