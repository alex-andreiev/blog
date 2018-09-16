# frozen_string_literal: true

Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  mount API::Base, at: '/'
  mount GrapeSwaggerRails::Engine, at: '/api/docs'

  devise_for :users
  root 'pages#show', page: 'home'
  get '/pages/:page' => 'pages#show'
  resources :posts
end
