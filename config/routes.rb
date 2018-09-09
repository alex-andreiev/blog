# frozen_string_literal: true

Rails.application.routes.draw do
  mount API::Base, at: '/'
  mount GrapeSwaggerRails::Engine, at: '/api/docs'

  devise_for :users
  root 'pages#show', page: 'home'
  get '/pages/:page' => 'pages#show'
  resources :posts
end
