# frozen_string_literal: true

# Class representing weather details for better abstraction
class Weather
  def initialize(data)
    # Use 'with_indifferent_access' for consistent access to data keys as symbols or strings
    @data = data.with_indifferent_access
  end

  # Method to get the URL for the weather icon
  def icon_url
    "https://openweathermap.org/img/wn/#{current_weather[:icon]}@2x.png"
  end

  # Method to get the overall weather status
  def status
    current_weather[:main]
  end

  # Method to get the detailed weather description
  def description
    current_weather[:description]
  end

  # Method to get the current temperature
  def current_temperature
    data.dig(:main, :temp)
  end

  # Method to get the feels-like temperature
  def feels_like_temperature
    data.dig(:main, :feels_like)
  end

  # Method to get the wind speed
  def wind_speed
    data.dig(:wind, :speed)
  end

  # Method to get the high temperature
  def high_temperature
    data.dig(:main, :temp_max)
  end

  # Method to get the low temperature
  def low_temperature
    data.dig(:main, :temp_min)
  end

  # Method to get the city name
  def city
    data[:name]
  end

  private

  attr_reader :data

  # Method to get the details of the current weather
  def current_weather
    @current_weather ||= data[:weather].first
  end
end
