Rails.application.routes.draw do
  devise_for :users
  resources :service_areas
  root "dashboard#index"
end
