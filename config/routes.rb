Rails.application.routes.draw do
  root "static_pages#home"

  get "/static_pages/team", to: "static_pages#team"

  get "/static_pages/contact", to: "static_pages#contact"

  get "welcome/:name", to: "welcome#user"
end
