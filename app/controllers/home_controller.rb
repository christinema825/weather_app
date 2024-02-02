# frozen_string_literal: true

class HomeController < ApplicationController
  include Geocoder

  # Action to get coordinates based on the provided address
  def get_coordinates
    address = params[:address]
    results = Geocoder.search(address)

    if results.present?
      coordinates = results.first.coordinates
      latitude = coordinates[0]
      longitude = coordinates[1]
      get_weather(latitude, longitude)

      return if performed?

      render :show
    else
      # If no coordinates found, set flash error and redirect to root_path
      flash[:error] = 'Location not found. Please enter a valid address.'
      redirect_to root_path
    end
  end

  # Private method to get weather information based on latitude and longitude
  private

  def get_weather(latitude, longitude)
    if latitude.present? && longitude.present?
      cache_key = "coordinates_#{longitude}_#{latitude}"
      @cached_indicator = Rails.cache.exist?(cache_key)

      if @cached_indicator
        # Use cached data if available
        @data = Rails.cache.read(cache_key)
      else
        # Fetch current weather data using a service and store it in the cache
        @data = CurrentWeatherService.new(latitude: latitude, longitude: longitude, units: 'imperial').call
        Rails.cache.write(cache_key, @data, expires_in: 30.minutes)
      end
      if @data.present? && @data['weather'].present?
        # Create a Weather object for better abstraction and easy access to weather details
        @weather = Weather.new(@data)

      else
        # If weather data is invalid, set flash error and redirect to root_path
        flash[:error] = 'Invalid weather data'
        redirect_to root_path
      end
    else
      # If location is invalid, set flash error and redirect to root_path
      flash[:error] = 'Invalid location'
      redirect_to root_path
    end
  rescue StandardError => e
    # Handle any unexpected errors, set flash error, and redirect to root_path
    flash[:error] = e.message
    redirect_to root_path
  end
end
