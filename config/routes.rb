Rails.application.routes.draw do

  root to: "home#index"
  get '/login', to: "sessions#new"
  post '/login', to: "sessions#create"
  get '/breeds', to: "breeds#index"
  get '/breeds/:name', to: "breeds#show", as: "breed"
  get '/cats', to: "cats#index"
  get '/cats/:id', to: "cats#show", as: "cat"
  post '/cart_items', to: "cart_items#create"
  get '/cart_items', to: "cart_items#show", as: "cart"
  post '/order_cats', to: "order_cats#create"
  get '/order/:id', to: "orders#show", as: "order"

  scope '/admin' do
    get '/inventory', to: "home#show"
    get '/breeds/:id/edit', to: "breeds#edit", as: "edit_breed"
    get '/cats/:id/edit', to: "cats#edit", as: "edit_cat"
  end
end
