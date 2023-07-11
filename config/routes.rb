Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"
  get '/categories/:id', to: 'categories#show', as: 'category'
  get '/products/:id', to: 'products#show', as: 'product'

  post 'products/add_to_cart', to: 'products#add_to_cart', as: 'add_to_cart'
  delete 'products/remove_from_cart/:id', to: 'products#remove_from_cart', as: 'remove_from_cart'

  get '/cart', to: 'cart#index', as: 'cart'
  put '/cart', to: 'cart#update', as: 'update_cart'
  get '/search', to: "search#index"

  get '/account/:id', to: "account#show", as: 'account'
  get '/account/:id/edit', to: "account#edit", as: 'account_edit'

  #resource :contact, only: [:show]
  resource :about, only: [:show]

  devise_for :accounts
end
