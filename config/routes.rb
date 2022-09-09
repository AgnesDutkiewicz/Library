Rails.application.routes.draw do
  root 'books#index'

  resources :books
  resources :publishers, except: [:destroy]
  resources :authors, except: [:destroy]
end
