console.log('person');

const personName = document.querySelector(".person-name");
const personDepartment = document.querySelector(".person-department");
const personProfile = document.querySelector(".person-profile");
const display = document.querySelector(".display-fetched-people");
const submitButton = document.querySelector(".add-person");
const people = [];


function createPersonInfo(person) {
  const personInfo = {
    name: person.name,
    profile_url: `https://image.tmdb.org/t/p/w500${person.profile_path}`,
    department: person.known_for_department
  }
  return personInfo;
}

function generateCard(person) {
  const personInfo = createPersonInfo(person);
  people.push(personInfo);
  const personCard =
    `<div class="person-card" style="cursor: pointer">
      <img src="${person.profile_path ? personInfo["profile_url"] : ''}" data-index="${people.length - 1}" alt="${personInfo["title"]}" class="movie-poster">
      <div class="person-card-infos">
        <div>
          <h2 class="person-name">${personInfo["name"]}</h2>

        </div>
      </div>
    </div>`
  display.insertAdjacentHTML("beforeend", personCard);
}

function selectPerson() {
  const cards = document.querySelectorAll(".person-card");
  for (let i = 0; i < cards.length; i++) {
    // console.log(cards[i]);
    cards[i].addEventListener('click', function (e) {
      console.log("I am clicking");
      console.log(e.target);
      const selectedPersonIndex = e.target.getAttribute('data-index')
      const selectedPerson = people[selectedPersonIndex]
      console.log(selectedPerson);
      personName.value = selectedPerson["name"];
      personDepartment.value = selectedPerson["department"];
      personProfile.value = selectedPerson["profile_url"];
      submitButton.click();

    }, false);
  }
}

function fetchPerson(e) {
  console.log(e);
  while (display.firstChild) {
    display.removeChild(display.firstChild);
  }
  const url = `https://api.themoviedb.org/3/search/person?api_key=b04a4d29fa7cbdec4d7960abf964d46f&language=en-US&query=${personName.value}&page=1&include_adult=false`
  fetch(url)
    .then((response) => response.json())
    .then((data) => {
      console.log(data.results);
      data.results.forEach(generateCard, this.person)
    }
    )
    .then(selectPerson)
}

personName.addEventListener("keyup", fetchPerson);
