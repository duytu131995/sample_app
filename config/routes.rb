Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    resources :test
  end
end
