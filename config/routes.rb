Rails.application.routes.draw do
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
 resources :tasks
 resources :users
 
  get "signup" ,to: "users#new"
  
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  
  get "logout", to: "sessions#destroy"
  delete "logout", to: "sessions#destroy"

 root to: "tasks#index"
end
