# spec/services/current_weather_service_spec.rb
require 'rails_helper'
require 'webmock/rspec'

RSpec.describe CurrentWeatherService, type: :service do
  let(:latitude) { 37.7749 }
  let(:longitude) { -122.4194 }
  let(:api_key) { ENV['OPENWEATHER_API_KEY'] }

  before do
    allow(ENV).to receive(:[]).with('OPENWEATHER_API_KEY').and_return(api_key)
  end

  it 'returns weather data' do
    stub_request(:get, "https://api.openweathermap.org/data/2.5/weather?appid=#{api_key}&lat=#{latitude}&lon=#{longitude}&units=imperial")
      .with(
        headers: {
          'Accept' => '*/*',
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Host' => 'api.openweathermap.org',
          'User-Agent' => 'Ruby'
        }
      )
      .to_return(status: 200, body: '{"weather": [{"description": "Clear"}]}', headers: {})

    service = CurrentWeatherService.new(latitude: latitude, longitude: longitude)
    result = service.call

    expect(result).to be_a(Hash)
    expect(result['weather']).to be_an(Array)
    expect(result['weather'][0]['description']).to eq('Clear')
  end
end
