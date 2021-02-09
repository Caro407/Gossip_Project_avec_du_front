Rails.application.routes.draw do
  resources :gossips
  resources :welcome, only: [:show]
  resources :user_profile, only: [:show]

  root "gossips#index"

  get "/static_pages/team", to: "static_pages#team"

  get "/static_pages/contact", to: "static_pages#contact"
end
