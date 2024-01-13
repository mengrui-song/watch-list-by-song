# 🎥 SuperWatchList

_An app helps create watch list and also actor/actress, director list using database from TMDB._
<br>
App home: [https://healthway.live](https://watch-list-by-song.herokuapp.com/)
   

## Getting Started
### Setup

Install gems
```
bundle install
```
Install JS packages
```
yarn install
```

### ENV Variables
Create `.env` file
```
touch .env
```
Inside `.env`, set these variables. For any APIs, see group Slack channel.
```
CLOUDINARY_URL=your_own_cloudinary_url_key
```

### DB Setup
```
rails db:create
rails db:migrate
rails db:seed
```

### Run a server
```
rails s
```

## Built With
- Rails 7 - Backend / Front-end
- JavaScript - Front-end JS
- Heroku- Deployment
- PostgreSQL - Database
- Bootstrap — Styling
- Figma — Prototyping


## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

