Rails.application.routes.draw do
  devise_for :users
  resources :customers do
    resources :transactions, only: [:create, :update, :destroy]
  end
  resources :service_areas
  root "dashboard#index"
end
