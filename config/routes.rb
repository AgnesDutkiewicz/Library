Rails.application.routes.draw do
  resource :session

  get 'signup' => 'users#new'
  resources :users

  root 'books#index'

  resources :books do
    resources :reservations
  end
  resources :reservations, only: [:index, :show]
  resources :publishers
  resources :authors
end
