# ForecastNow - Weather Forecast Application

https://github.com/christinema825/weather_app/assets/84738911/db56e35d-292c-454c-abd8-e28dde5521cd

## Table of Contents
- [Overview](#overview)
- [Features](#features)
- [Dependencies](#dependencies)
- [Installation](#installation)
- [Usage](#usage)
- [Unit Tests](#unit-tests)
- [Code Structure](#code-structure)
- [Design Patterns](#design-patterns)
- [Naming Conventions](#naming-conventions)
- [Encapsulation](#encapsulation)
- [Code Re-Use](#code-re-use)
- [UI](#ui)

## Overview
ForecastNow is a Ruby on Rails application that allows users to retrieve and display weather forecast details based on a provided address. The application utilizes the OpenWeatherMap API to fetch real-time weather data.

## Features
- Accepts an address as input.
- Retrieves current temperature and other forecast details.
- Displays the forecast information to the user.
- Caches forecast details for 30 minutes, reducing API calls and improving response time.
- Indicates if the result is pulled from the cache.

## Dependencies
- Ruby on Rails
- Geocoder gem
- [OpenWeatherMap API Key](https://openweathermap.org/appid) (required for weather data)
- [Geocoding API Key](https://developers.google.com/maps/documentation/geocoding/get-api-key) (required for coordinates data)

## Installation
1. Clone the repository: `git clone https://github.com/christinema825/weather_app.git`
2. Install dependencies: `bundle install`
3. Set up environment variables:
   - Copy `.env.example` to `.env` and add your OpenWeatherMap API key & Google Geocoding API key .
        - `OPENWEATHER_API_KEY=your_api_key_here`
        - `GOOGLE_GEOCODING_API_KEY=your_google_geocoding_api_key_here`

## Usage
1. Start the Rails server: `rails server`
2. Access the application in a web browser at `http://localhost:3000`

## Unit Tests
The project includes comprehensive unit tests to ensure the reliability of the code. To run tests, use the command: `rspec`

## Code Structure
- **HomeController**: Manages the main functionality of getting coordinates and weather details.
- **Weather**: Represents weather details, providing abstraction for better code structure.
- **CurrentWeatherService**: Service class for fetching weather data from the OpenWeatherMap API.

## Design Patterns
1. Service Object Pattern:
**Implementation**: The CurrentWeatherService class follows the Service Object pattern. It encapsulates the logic for fetching weather data from the OpenWeatherMap API. This promotes separation of concerns, making the code more modular and easier to maintain.
2. Decorator Pattern:
**Implementation**: The Weather class can be seen as a decorator for the raw weather data obtained from the API. It provides methods to extract specific details and enhances the usability of the weather data by encapsulating it with methods like icon_url, status, etc.
3. Factory Pattern (Partially Applied):
**Implementation**: The use of CurrentWeatherService.new in the HomeController can be seen as a basic form of a Factory Pattern. It encapsulates the instantiation of the service object, providing a consistent way to create instances.
4. MVC (Model-View-Controller) Pattern:
**Implementation**: The entire Rails application adheres to the MVC pattern, where the HomeController serves as the controller, the Weather class encapsulates the model-like behavior, and the views (HTML/ERB files) represent the views. This pattern promotes separation of concerns and maintainability.

## Naming Conventions
Follow industry-standard naming conventions for variables, classes, and methods to ensure code clarity and consistency.

## Encapsulation
Encapsulation is employed to keep methods focused and to prevent one method from performing too many tasks.

## Code Re-Use
Leverage code re-use where applicable to maintain a clean and modular codebase.

## UI
The application features a simple and user-friendly UI allowing users to input an address and retrieve weather information. The UI also indicates whether the data is retrieved from the cache.


