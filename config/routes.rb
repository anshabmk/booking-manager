Rails.application.routes.draw do
  root 'sessions#new'

  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  get 'bill_amounts/show/:token' => 'bill_amounts#show'
  get 'bill_amounts' => 'bill_amounts#index'

  resources :players
  resources :games
  resources :bills

  get 'bills/:id/send_notification_message' => 'bills#send_notification_message'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
