# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root 'pages#show', page: 'home'
  get '/:page' => 'pages#show'
end
