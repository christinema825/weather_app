# frozen_string_literal: true

# Service class to fetch current weather data from the OpenWeatherMap API
class CurrentWeatherService
  BASE_URL = 'https://api.openweathermap.org/data/2.5/weather'
  API_KEY = ENV['OPENWEATHER_API_KEY']

  # Constructor to initialize the service with latitude, longitude, and units
  def initialize(latitude:, longitude:, units: 'imperial')
    @latitude = latitude
    @longitude = longitude
    @units = units
  end

  # Public method to make the API call and retrieve current weather data
  def call
    response = Net::HTTP.get_response(uri)
    JSON.parse(response.body)
  end

  private

  # Private method to build the URI for the OpenWeatherMap API request
  def uri
    return @uri if defined?(@uri)

    @uri = URI(BASE_URL)
    params = { lat: latitude, lon: longitude, units: units, appid: API_KEY }
    @uri.query = URI.encode_www_form(params)
    @uri
  end

  # Private getters for latitude, longitude, and units
  attr_reader :latitude, :longitude, :units
end
