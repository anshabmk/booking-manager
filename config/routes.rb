Rails.application.routes.draw do
  root 'games#index'

  resources :players
  resources :games
  resources :bills
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
