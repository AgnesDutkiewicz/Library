Rails.application.routes.draw do
  resource :session

  get 'signup' => 'users#new'
  resources :users

  root 'books#index'

  resources :books
  resources :publishers, except: [:destroy]
  resources :authors, except: [:destroy]
end
