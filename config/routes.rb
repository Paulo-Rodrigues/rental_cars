Rails.application.routes.draw do
  devise_for :users
  resources :clients, only: [:index, :show, :new, :create]
  resources :subsidiaries, only: [:index, :show, :new, :create, :edit, :update]
  resources :car_categories
  resources :car_models, only: [:index, :show, :new, :create]
  resources :cars, only: [:new, :show, :create]
  root to: 'home#index'
end
