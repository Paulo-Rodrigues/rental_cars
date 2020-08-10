Rails.application.routes.draw do
  resources :subsidiaries, only: [:index, :show]
  resources :car_categories, only: [:index, :show, :new, :create]
  root to: 'home#index'
end
