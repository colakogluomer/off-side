# OFFSIDE

Mobile systems project 2021/2022.

Tech Stack:

Backend --> NodeJS

Frontend --> Flutter

App is configured to use heroku server: [https://offside-backend.herokuapp.com/](https://offside-backend.herokuapp.com/).

## Using local environment

1. Prepare .env file depends on your constants.
2. Change serverUrl variable in [frontend/lib/constants/settings.dart](frontend/lib/constants/settings.dart). Address `10.0.2.2` in AVD is mapped to `localhost` on host machine.
3. Start the server using command `docker-compose up --build`.

Backend app can be accessed on [localhost:8080](http://localhost:8080).
