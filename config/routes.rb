Rails.application.routes.draw do
  get 'bills/index'
  root 'games#index'

  resources :players
  resources :games
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
