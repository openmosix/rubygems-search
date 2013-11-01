RubygemsSearch::Application.routes.draw do
  
  # Applications routes
  resources :gems
  
  get "/search" => 'gems#search'
  
  root "gems#index"
end