RubygemsSearch::Application.routes.draw do
  
  # Applications routes
  resources :gems
  
  root "gems#index"
end