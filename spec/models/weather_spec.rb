# spec/models/weather_spec.rb
require 'rails_helper'

RSpec.describe Weather, type: :model do
  let(:sample_data) do
    {
      'coord' => { 'lon' => 2.3522, 'lat' => 48.8566 },
      'weather' => [{ 'id' => 803, 'main' => 'Clouds', 'description' => 'broken clouds', 'icon' => '04n' }],
      'base' => 'stations',
      'main' => { 'temp' => 47.3, 'feels_like' => 46.2, 'temp_min' => 42.78, 'temp_max' => 49.05, 'pressure' => 1035,
                  'humidity' => 90 },
      'visibility' => 10_000,
      'wind' => { 'speed' => 3.44, 'deg' => 310 },
      'clouds' => { 'all' => 75 },
      'dt' => 1_706_818_119,
      'sys' => { 'type' => 2, 'id' => 2_012_208, 'country' => 'FR', 'sunrise' => 1_706_772_103,
                 'sunset' => 1_706_805_980 },
      'timezone' => 3600,
      'id' => 6_455_259,
      'name' => 'Paris',
      'cod' => 200
    }
  end

  subject { Weather.new(sample_data) }

  describe '#icon_url' do
    it 'returns the correct icon URL' do
      expect(subject.icon_url).to eq('https://openweathermap.org/img/wn/04n@2x.png')
    end
  end

  describe '#status' do
    it 'returns the correct status' do
      expect(subject.status).to eq('Clouds')
    end
  end

  describe '#description' do
    it 'returns the correct description' do
      expect(subject.description).to eq('broken clouds')
    end
  end

  describe '#current_temperature' do
    it 'returns the correct current temperature' do
      expect(subject.current_temperature).to eq(47.3)
    end
  end

  describe '#city' do
    it 'returns the correct city name' do
      expect(subject.city).to eq('Paris')
    end
  end
end
