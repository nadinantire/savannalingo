Rails.application.routes.draw do
  get "contacts/new"
  get "contacts/create"
  get "pages/home"
  get 'about', to: 'pages#about'
  get 'stories', to: 'pages#stories'
  get 'pages/contact'

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :books
 resources :posts do
  get 'new_content_block', on: :collection
end
  devise_for :users
  resources :categories
get 'categories/:id/posts', to: 'categories#user_posts', as: 'category_posts'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  root "pages#home"
  get 'contact', to: 'contacts#new', as: 'new_contact'
  post 'contacts', to: 'contacts#create', as: 'contacts'
 

  
end
