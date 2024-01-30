# frozen_string_literal: true

class Weather
  def initialize(data)
    @data = data.with_indifferent_access
  end

  def icon_url
    "https://openweathermap.org/img/wn/#{current_weather[:icon]}@2x.png"
  end

  def  
    current_weather[:main]
  end

  def description
    current_weather[:description]
  end

  def temperature
    data.dig(:main, :temp)
  end

  private 

  attr_reader :data

  def current_weather
    @current_weather ||= data[:weather].first
  end
end
