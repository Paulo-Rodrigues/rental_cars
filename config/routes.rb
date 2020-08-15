Rails.application.routes.draw do
  resources :subsidiaries, only: [:index, :show, :new, :create, :edit, :update]
  resources :car_categories
  resources :car_models, only: [:index, :show, :new, :create]
  root to: 'home#index'
end
