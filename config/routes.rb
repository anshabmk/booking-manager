Rails.application.routes.draw do
  root 'sessions#new'

  get 'activations/index'
  get 'activations/activate/:player_id' => 'activations#activate'

  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  get 'bill_amounts/show/:token' => 'bill_amounts#show'
  get 'bill_amounts' => 'bill_amounts#index'

  resources :players
  get 'player_signup' => 'players#new'
  post 'player_signup' => 'players#create'

  resources :games
  resources :bills

  get 'bills/:id/send_notification_message' => 'bills#send_notification_message'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
