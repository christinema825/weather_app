# frozen_string_literal: true

class Weather
  def initialize(data)
    @data = data.with_indifferent_access
  end

  def icon_url
    "https://openweathermap.org/img/wn/#{current_weather[:icon]}@2x.png"
  end

  def status
    current_weather[:main]
  end

  def description
    current_weather[:description]
  end

  def current_temperature
    data.dig(:main, :temp)
  end

  def feels_like_temperature
    data.dig(:main, :feels_like)
  end

  def wind_speed
    data.dig(:wind, :speed)
  end

  def high_temperature
    data.dig(:main, :temp_max)
  end

  def low_temperature
    data.dig(:main, :temp_min)
  end

  def city
    data[:name]
  end

  private 

  attr_reader :data

  def current_weather
    @current_weather ||= data[:weather].first
  end
end
