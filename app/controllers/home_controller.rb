# frozen_string_literal: true

class HomeController < ApplicationController
    def index
        url = "https://api.openweathermap.org/data/2.5/weather?lat=33.7490&lon=-84.3880&units=imperial&appid=3ab8998a4fdff1b2de0659060b4e7892"
        uri = URI(url)
        res = Net::HTTP.get_response(uri)
        # debugger
        @data = JSON.parse(res.body)
    end
end