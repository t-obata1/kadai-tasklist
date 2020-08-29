Rails.application.routes.draw do
  root to: "tasks#index"
  
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
 
  get "signup", to: "users#new"
  post "signup", to: "users#create"
  get "users", to: "tasks#index"

  resources :users, only: [:index, :new, :create]
  resources :tasks, only: [:create, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
