
const movieTitle = document.querySelector(".movie-title");
const movieOverview = document.querySelector(".movie-overview");
const movieRating = document.querySelector(".movie-rating");
const moviePoster = document.querySelector(".movie-poster");
const display = document.querySelector(".display-fetched-movies");
const submitButton = document.querySelector(".add-movie");
const movies = [];

console.log("This is search_movie.js");

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
    `<div class="movie-card" style="cursor: pointer">
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
    // console.log(cards[i]);
    cards[i].addEventListener('click', function (e) {
      console.log("I am clicking");
      movies.forEach(movie => {
        // console.log(movie["title"])
        console.log(e.target.getAttribute('alt'));
        if (movie["title"] === e.target.getAttribute('alt')) {
          movieTitle.value = movie["title"];
          movieOverview.value = movie["overview"];
          movieRating.value = movie["rating"];
          moviePoster.value = movie["poster_url"];
          console.log(movieTitle.value);
          submitButton.click();
        }
      })
    }, false);
  }
}

function fetchMovie(e) {
  while (display.firstChild) {
    display.removeChild(display.firstChild);
  }
  const url = `https://api.themoviedb.org/3/search/movie?api_key=b04a4d29fa7cbdec4d7960abf964d46f&language=en-US&query=${movieTitle.value}&page=1&include_adult=false`
  fetch(url)
    .then((response) => response.json())
    .then((data) =>
      data.results.forEach(generateCard, this.movie)
    )
    .then(selectMovie)
}

movieTitle.addEventListener("keyup", fetchMovie);