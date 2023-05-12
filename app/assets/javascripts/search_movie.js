console.log("hello, I am in search_movie");

movieTitle = document.querySelector(".movie-title");
movieTMDBId = document.querySelector(".movie-tmdb-id");
movieOverview = document.querySelector(".movie-overview");
movieRating = document.querySelector(".movie-rating");
moviePoster = document.querySelector(".movie-poster");
displayMovie = document.querySelector(".display-fetched-movies");
submitMovie = document.querySelector(".add-movie");
movies = [];

function createMovieInfo(movie) {
  const movieInfo = {
    title: movie.title,
    tmdb_id: movie.id,
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
  displayMovie.insertAdjacentHTML("beforeend", movieCard);
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
      console.log(movieTMDBId);
      movieTMDBId.value = selectedMovie["tmdb_id"];
      console.log(movieTMDBId);
      movieOverview.value = selectedMovie["overview"];
      movieRating.value = selectedMovie["rating"];
      moviePoster.value = selectedMovie["poster_url"];
      submitMovie.click();

    }, false);
  }
}

function fetchMovie(e) {
  console.log(e);
  while (displayMovie.firstChild) {
    displayMovie.removeChild(displayMovie.firstChild);
  }
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
