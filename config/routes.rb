Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#home"

    get "home", to: "static_pages#home", as: "home"
    get "help", to: "static_pages#help", as: "help"
    get "contact", to: "static_pages#contact", as: "contact"
    get "about", to: "static_pages#about", as: "about"
    get "sign_up", to: "users#new"
    post "sign_up", to: "users#create"
    resources :users, only: :show
  end
end
