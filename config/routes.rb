Rails.application.routes.draw do
  root to: 'welcome#index'

  resources :items, only: [:index, :show]
  resources :merchants, only: [:index]
  resources :users, only: [:show, :new, :edit, :create]

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
end
