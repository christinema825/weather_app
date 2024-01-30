# frozen_string_literal: true

class HomeController < ApplicationController
  include Geocoder

  def get_weather(latitude, longitude)
    begin
      if latitude.present? && longitude.present?
        @data = CurrentWeatherService.new(latitude: latitude, longitude: longitude, units: 'imperial').call
        if @data.present? && @data['weather'].present?
          @weather = Weather.new(@data)
          render action: 'show'
        else
          raise StandardError, 'Invalid weather data'
        end
      else
        raise StandardError, 'Invalid location'
      end
    rescue StandardError => e
      flash[:error] = e.message
      redirect_to root_path
    end
  end

  def get_coordinates
    address = params[:address]

    results = Geocoder.search(address)
    if results.present?
      coordinates = results.first.coordinates
      latitude = coordinates[0]
      longitude = coordinates[1]
      get_weather(latitude, longitude)
    else
      flash[:error] = 'Location not found. Please enter a valid address.'
      redirect_to root_path
    end
  end
end
