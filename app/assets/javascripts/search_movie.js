console.log("movie");

const movieTitle = document.querySelector(".movie-title");
const movieOverview = document.querySelector(".movie-overview");
const movieRating = document.querySelector(".movie-rating");
const moviePoster = document.querySelector(".movie-poster");
const display = document.querySelector(".display-fetched-movies");
const submitButton = document.querySelector(".add-movie");
const movies = [];

console.log(display);
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
      <img src="${movie.poster_path ? movieInfo["poster_url"] : ''}" data-index="${movies.length - 1}" alt="${movieInfo["title"]}" class="movie-poster">
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
  let finish = false;
  for (let i = 0; i < cards.length; i++) {
    // console.log(cards[i]);
    cards[i].addEventListener('click', function (e) {
      console.log("I am clicking");
      console.log(e.target);
      const selectedMovieIndex = e.target.getAttribute('data-index')
      const selectedMovie = movies[selectedMovieIndex]
      console.log(selectedMovie);
      movieTitle.value = selectedMovie["title"];
      movieOverview.value = selectedMovie["overview"];
      movieRating.value = selectedMovie["rating"];
      moviePoster.value = selectedMovie["poster_url"];
      submitButton.click();

    }, false);
  }
}

function fetchMovie(e) {
  console.log(e);
  // while (display.firstChild) {
  //   display.removeChild(display.firstChild);
  // }
  const url = `https://api.themoviedb.org/3/search/movie?api_key=b04a4d29fa7cbdec4d7960abf964d46f&language=en-US&query=${movieTitle.value}&page=1&include_adult=false`
  fetch(url)
    .then((response) => response.json())
    .then((data) => {
      console.log(data);
      data.results.forEach(generateCard, this.movie)
    }
    )
    .then(selectMovie)
}

movieTitle.addEventListener("keyup", fetchMovie);
