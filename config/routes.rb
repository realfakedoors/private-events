Rails.application.routes.draw do
  
  root 'sessions#new'
  
  get  '/login',         to: 'sessions#new'
  post '/login',         to: 'sessions#create'
  delete '/logout',      to: 'sessions#destroy'
  
  get  '/signup',        to: 'users#new'
  post '/signup',        to: 'users#create'
  
  resources :users,    only: [:show, :new, :create]
  
end