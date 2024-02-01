Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "home#index"
  get "get_coordinates", to: "home#get_coordinates"
  get "get_weather", to: "home#get_weather"
  get "show", to: "home#show"
end
