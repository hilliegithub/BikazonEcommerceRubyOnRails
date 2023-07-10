Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"
  get '/categories/:id', to: 'categories#show', as: 'category'
  get '/products/:id', to: 'products#show', as: 'product'
  devise_for :accounts
end
