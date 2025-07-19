Rails.application.routes.draw do
  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker


  get "/help", to: "static_pages#help"
  # get "static_pages/about"
  get "/about", to: "static_pages#about"
  # get "static_pages/contact"
  get "/contact", to: "static_pages#contact"
  get "/signup", to: "users#new"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  resources :users
  resources :account_activations, only: [ :edit ]
  resources :password_resets, only: [ :new, :create, :update, :edit ]

  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "static_pages#home"
end
