Rails.application.routes.draw do
  resources :gossips do
    resources :comments
  end

  resources :gossips do
    resources :likes, except: [:edit, :update]
  end

  resources :welcome, only: [:show]
  resources :users, only: [:show, :new, :create]
  resources :city, only: [:show]
  resources :sessions, only: [:new, :create]

  delete "/sessions", to: "sessions#destroy", as: "delete_session"

  #get "/gossip/:gossip_id/like", to: "likes#add", as: "add_like"

  root "gossips#index"

  get "/static_pages/team", to: "static_pages#team"

  get "/static_pages/contact", to: "static_pages#contact"
end
