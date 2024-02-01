# frozen_string_literal: true

class HomeController < ApplicationController
  include Geocoder

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

private

def get_weather(latitude, longitude)
    if latitude.present? && longitude.present?
      cache_key = "coordinates_#{longitude}_#{latitude}"
      @cached_indicator = Rails.cache.exist?(cache_key)
    
      if @cached_indicator
        @data = Rails.cache.read(cache_key)
      else
        @data = CurrentWeatherService.new(latitude: latitude, longitude: longitude, units: 'imperial').call
        Rails.cache.write(cache_key, @data, expires_in: 30.minutes)
      end
      puts "DATAAAAA: #{@data}"
      if @data.present? && @data['weather'].present?
        @weather = Weather.new(@data)
        render action: 'show'
      else
        flash[:error] = 'Invalid weather data'
        redirect_to root_path
      end
    else
        flash[:error] = 'Invalid location'
        redirect_to root_path
    end
  rescue StandardError => e
    flash[:error] = e.message
    redirect_to root_path
  end
end

