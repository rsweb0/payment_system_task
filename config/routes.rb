# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root 'merchants#show'

  get 'login' => 'sessions#new', as: :login
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy', as: :logout

  resource :merchants, only: [:show]
  resources :transactions, only: %i[new create]
  post 'transactions/:transaction_type/:transaction_id' => 'transactions#create'
end
