Rails.application.routes.draw do
  root "gossips#index"

  get "/static_pages/team", to: "static_pages#team"

  get "/static_pages/contact", to: "static_pages#contact"

  get "/welcome/:name", to: "welcome#user", as: "welcome"

  get "/gossips/:id", to: "gossips#show", as: "gossips"

  get "/user_profile/:id", to: "user_profile#show", as: "user_profile"
end
