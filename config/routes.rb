# rubocop:disable  Metrics/BlockLength
# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :authors
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  root to: 'posts#index'

  get '/notify/:id', to: 'posts#notify'

  get '/delete_content/:id', to: 'posts#delete_content'

  resources :posts, only: %i[index show create new destroy] do
    resources :comments, only: %i[show create new destroy]
  end

  resources :posts, only: [:index]

  resources :comments, only: %i[show create new destroy] do
    resources :comments, only: %i[show create new destroy]
  end

  resources :categories

  resources :votes

  resources :authors

  resources :notifications, only: [:index]
  get 'notifications/mark_read', to: 'notifications#mark_read'

  namespace :api do
    get 'author/email_exists', to: 'author#email_exists'
    get 'notifications/count', to: 'notifications#count'
    resources :posts, only: [:index]
    resources :author, only: [:index]
  end

  resources :reports, only: [:index]
  resources :posts do
    resources :reports, only: [:create]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
# rubocop:enable  Metrics/BlockLength
