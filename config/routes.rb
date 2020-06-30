Rails.application.routes.draw do
  get 'followers/index'
  get 'following/index'
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#home"

    get "home", to: "static_pages#home", as: "home"
    get "help", to: "static_pages#help", as: "help"
    get "contact", to: "static_pages#contact", as: "contact"
    get "about", to: "static_pages#about", as: "about"
    get "sign_up", to: "users#new"
    post "sign_up", to: "users#create"
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
    resources :users do
      member do
        get :following, to: "following#index", as: "following"
        get :followers, to: "followers#index", as: "followers"
      end
    end
    resources :account_activations, only: :edit
    resources :password_resets, except: %i(show index destroy)
    resources :microposts, only: %i(create destroy)
    resources :relationships, only: %i(create destroy)
  end
end
