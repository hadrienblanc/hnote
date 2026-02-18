Rails.application.routes.draw do
  devise_for :users
  resources :notes
  get "up" => "rails/health#show", as: :rails_health_check
  root "notes#index"
end
