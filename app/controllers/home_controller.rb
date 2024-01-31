# frozen_string_literal: true

class HomeController < ApplicationController
  include Geocoder

  def get_weather(latitude, longitude)
    if latitude.present? && longitude.present?

      cache_key = "coordinates_#{longitude}_#{latitude}"

      @cached_indicator = Rails.cache.exist?(cache_key)
#refactor later
      if @cached_indicator
        @data = Rails.cache.read(cache_key)
      else
        @data = CurrentWeatherService.new(latitude: latitude, longitude: longitude, units: 'imperial').call
        Rails.cache.write(cache_key, @data, expires_in: 30.minutes)
      end

      if @data.present? && @data['weather'].present?
        puts "DATA INFORMATION:::: #{@data}"
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
