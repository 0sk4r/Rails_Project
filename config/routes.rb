# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :authors
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  root to: 'posts#index'

  get '/notify/:id', to: 'posts#notify'

  resources :posts, only: %i[index show create new destroy] do
    resources :comments, only: %i[show create new destroy]
  end

  resources :comments, only: %i[show create new destroy] do
    resources :comments, only: %i[show create new destroy]
  end

  resources :categories

  resources :votes

  resources :authors

  namespace :api do
    get 'author/email_exists', to: 'author#email_exists'
    resources :author, only: [:index]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
