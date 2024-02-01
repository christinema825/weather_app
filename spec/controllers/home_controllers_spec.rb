# spec/controllers/home_controller_spec.rb
require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  let(:address) { '123 Main Street' }
  let(:latitude) { 37.7749 }
  let(:longitude) { -122.4194 }

  before do
    allow(controller).to receive(:flash).and_return({}) # Stub flash messages
  end

  describe 'GET #get_coordinates' do
    shared_examples 'coordinates behavior' do
      it 'calls get_weather with correct coordinates' do
        if results.present? && results.first.coordinates.present?
          expect(controller).to receive(:get_weather).with(latitude, longitude)
        else
          expect(controller).not_to receive(:get_weather)
        end

        get :get_coordinates, params: { address: address }
      end
    end

    context 'when valid coordinates are found' do
      let(:results) do
        double('geocoder_results', present?: true, first: double('result', coordinates: [latitude, longitude]))
      end

      before do
        allow(Geocoder).to receive(:search).and_return(results)
        allow(controller).to receive(:get_weather)
      end

      include_examples 'coordinates behavior'

      it 'renders the show template' do
        get :get_coordinates, params: { address: address }
        expect(response).to render_template('show')
      end
    end

    context 'when valid coordinates are not found' do
      let(:results) { double('geocoder_results', present?: false) }

      before do
        allow(Geocoder).to receive(:search).and_return(results)
      end

      include_examples 'coordinates behavior'

      it 'sets flash error and redirects to root_path' do
        get :get_coordinates, params: { address: address }
        expect(flash[:error]).should_not be_nil
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'GET #get_coordinates' do
    let(:valid_address) { '123 Main Street' }
    let(:cached_data) { { 'weather' => [{ 'description' => 'Clear' }] } }

    before do
      allow(Geocoder).to receive(:search).with(valid_address).and_return([double(coordinates: [latitude, longitude])])
    end

    it 'calls get_weather with correct coordinates' do
      allow(Rails.cache).to receive(:exist?).and_return(false)
      allow(CurrentWeatherService).to receive(:new).and_return(instance_double('CurrentWeatherService',
                                                                               call: cached_data))

      expect(controller).to receive(:get_weather).with(latitude, longitude)
      get :get_coordinates, params: { address: valid_address }
    end

    context 'when coordinates are cached' do
      it 'uses cached data' do
        allow(Rails.cache).to receive(:exist?).and_return(true)
        allow(Rails.cache).to receive(:read).and_return(cached_data)

        expect(controller).to receive(:get_weather).with(latitude, longitude).and_call_original
        get :get_coordinates, params: { address: valid_address }

        expect(assigns(:data)).to eq(cached_data)
      end
    end
  end
end
