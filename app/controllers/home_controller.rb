# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @data = CurrentWeatherService.new(latitude: '33.7490', longitude: '-84.3880', units: 'imperial').call
    @weather = Weather.new(@data)
  end
end
