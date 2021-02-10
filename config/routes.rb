Rails.application.routes.draw do
  resources :gossips do
    resources :comments
  end
  resources :welcome, only: [:show]
  resources :user_profile, only: [:show]
  resources :city, only: [:show]

  root "gossips#index"

  get "/static_pages/team", to: "static_pages#team"

  get "/static_pages/contact", to: "static_pages#contact"
end
