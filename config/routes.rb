Rails.application.routes.draw do
  get 'bill_amounts/show/:token' => 'bill_amounts#show'
  root 'bills#index'

  resources :players
  resources :games
  resources :bills

  get 'bills/:id/send_notification_message' => 'bills#send_notification_message'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
