# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: "homepage#index"
  get '/login', to: 'users#login_form'
  post '/login', to: 'users#login_user'
  get '/register', to: 'users#new' 

  resources :users, only: [:show, :create] do
    resources :discover, only: [:index]
    resources :movie, only: [:index, :show] do 
      resources :viewing_party, only: [:new, :create]
    end
  end
end
