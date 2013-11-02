RubygemsSearch::Application.routes.draw do
  
  # Applications routes
  resources :gems
  
  get "/search" => 'gems#search'
  
  get "/advanced" => 'gems#advanced_search'
  
  root "gems#index"
end