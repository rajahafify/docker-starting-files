# rails-docker-starter-pack

## Setup

1.  First, download and install [Docker for Mac](https://docs.docker.com/engine/installation/mac/).
2.  Update the `change-me-sync:` in `docker-sync.yml` and `docker-compose.yml` to `your-app-name-sync:`
3.  Make sure that you have installed `docker-sync`: `gem install docker-sync`.
4.  Once everything is ready, run `docker-sync-stack start`.
5.  In a different console, if you doing this the first time, run `docker-compose run app rake db:create` and `docker-compose run app rake db:schema:load` to have your database set up.
6.  To access the API, visit `localhost:3000` in your browser.
