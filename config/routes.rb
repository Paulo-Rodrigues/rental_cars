Rails.application.routes.draw do
  resources :subsidiaries, only: [:index, :show, :new, :create, :edit, :update]
  resources :car_categories
  root to: 'home#index'
end
