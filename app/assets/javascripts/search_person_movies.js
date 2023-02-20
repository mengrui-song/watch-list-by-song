// window.addEventListener('beforeunload', function() {
//   window.location.reload();
// });
console.log("I am in search person's movies");
personId = document.querySelector(".person-id");
displayCastMovie = document.querySelector(".movie-cards.cast");
displayCrewMovie = document.querySelector(".movie-cards.crew");
castMovies = []
console.log(personId.innerText);

  fetch(`https://api.themoviedb.org/3/person/${personId.innerText}/movie_credits?api_key=b04a4d29fa7cbdec4d7960abf964d46f`)
    .then((response) => response.json())
    .then((data) => {
      console.log(data);
      data.cast.forEach(generateCastCard, this.movie);
      data.crew.forEach(generateCrewCard, this.movie);
    }
    )

    function createMovieInfo(movie) {
      console.log(movie);
      const movieInfo = {
        title: movie.title,
        poster_url: `https://image.tmdb.org/t/p/w500${movie.poster_path}`,
        overview: movie.overview,
        // rating: movie.vote_average
      }
      return movieInfo;
    }

    function generateMovieCard(movieInfo) {
      const movieCard =
        `<div class="movie-card" style="cursor: pointer">
          <img src="${movieInfo["poster_url"] ? movieInfo["poster_url"] : ''}" alt="${movieInfo["title"]}" class="movie-poster">
          <div class="movie-card-infos">
            <div>
              <h2 class="movie-title">${movieInfo["title"]}</h2>
            </div>
          </div>
        </div>`
      return movieCard;
    }

    function generateCastCard(movie) {
      const movieInfo = createMovieInfo(movie);
      const movieCard = generateMovieCard(movieInfo);
      displayCastMovie.insertAdjacentHTML("beforeend", movieCard);
    }
    function generateCrewCard(movie) {
      const movieInfo = createMovieInfo(movie);
      const movieCard = generateMovieCard(movieInfo);
      displayCrewMovie.insertAdjacentHTML("beforeend", movieCard);
    }