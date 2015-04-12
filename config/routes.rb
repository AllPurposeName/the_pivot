Rails.application.routes.draw do
  root to: "home#index"
  get '/items', to: "home#items"
  get '/stores', to: "home#stores"

  get '/login', to: "sessions#new"
  post '/login', to: "sessions#create"
  get "/logout", to: "sessions#logout"
  resources :users, only: [:new, :create]

  resources :categorys, only: [:index]
  get '/categorys/:name', to: "breeds#show", as: "breed"
  resources :order_garments, only: [:create]
  resources :orders, only: [:index, :show]
  resources :cart_items, only: [:create, :show]
  get '/cart_items', to: "cart_items#show", as: "cart"
  patch '/cart_items', to: "cart_items#increment", as: "increment_cart_items"
  put '/cart_items', to: "cart_items#decrement", as: "decrement_cart_items"
  delete '/cart_items', to: "cart_items#delete"

  namespace :admin do
    resources :inventory, only: [:index]
    resources :categorys, except: [:index]
    resources :garments, except: [:index]
    put '/garments/js/:id', to: 'garments#retired_update'
    resources :orders, only: [:index, :update]
  end

  namespace :sellers, as: :seller, path: "/:slug" do
    get '/', to: "garments#index"
    resources :garments
    resources :categorys
    resources :orders
    get '/dashboard', to: "dashboard#show"
  end

end
