# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :authors
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  root to: 'posts#index'

  get '/notify/:id', to: 'posts#notify'

  resources :posts, only: [:index, :show, :create, :new, :destroy] do
    resources :comments, only: [:show, :create, :new, :destroy]
  end

  resources :comments, only: [:show, :create, :new, :destroy] do
    resources :comments, only: [:show, :create, :new, :destroy]
  end

  resources :votes

  resources :authors

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
