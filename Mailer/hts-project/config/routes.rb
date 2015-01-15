Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "users/registrations" }
  devise_for :admins, controllers: { sessions: "admins/sessions" }

  require 'sidekiq/web'

  mount Sidekiq::Web => '/sidekiq'

  namespace :admins do
    root 'pages#index'
    get '/photoalbums' => 'photoalbums#index'
    get '/persondata' => 'pages#json_query'
    resources :photoalbums
  end

  resources :photoalbums do
    resources :photos #nested routes
  end

  resources :pages

  get 'process/new' => 'process#new'
  post 'process/new' => 'process#create'
  get 'process/check_person' => 'process#check_person'
  post 'process/create_person' => 'process#create_person'
  get 'process/read_pictures' => 'process#read_pictures'
  get '/pof' => 'pof#index'
  root 'pages#index'
  get 'groupphotos' => 'groupphotos#index'
  get 'groupphotos/:q' => 'groupphotos#public_index'

 end
