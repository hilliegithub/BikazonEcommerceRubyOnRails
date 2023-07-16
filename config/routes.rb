Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"
  get '/categories/:id', to: 'categories#show', as: 'category'
  get '/products/:id', to: 'products#show', as: 'product'

  post 'products/add_to_cart', to: 'products#add_to_cart', as: 'add_to_cart'

  get '/cart', to: 'cart#index', as: 'cart'
  put '/cart', to: 'cart#update', as: 'update_cart'
  post '/cart/remove', to: 'cart#remove', as: 'remove_on_cart'
  delete 'cart/remove_from_cart', to: 'cart#remove_from_cart', as: 'remove_from_cart'
  #delete 'products/remove_from_cart/:id', to: 'products#remove_from_cart', as: 'remove_from_cart'
  get '/search', to: "search#index"

  get '/account/:id', to: "account#show", as: 'account'
  get '/account/:id/edit', to: "account#edit", as: 'account_edit'
  patch '/account/:id/edit', to: "account#update", as: 'account_update'
  #resource :contact, only: [:show]
  get '/about', to: "about#index", as: 'about'
  get '/contact', to: "contact#index", as: 'contact'

  get '/checkout/address', to:'checkout#address', as:'checkout_address'
  post '/checkout/address/update', to:'checkout#address_update', as: 'checkout_address_update'
  get 'checkout/stripe', to: 'checkout#stripe', as: 'checkout_stripe'
  post '/checkout', to: 'checkout#index', as: 'checkout'

  get '/success', to: 'checkout#success'
  get '/cancel', to: 'checkout#cancel'
  devise_for :accounts
end
