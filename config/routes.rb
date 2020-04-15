Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get "/", to: "welcome#index"

  get "/register", to: "users#new"
  post "/register", to: "users#create"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  post "/cart/:item_id", to: "cart#add_item"
  get "/cart", to: "cart#show"
  delete "/cart", to: "cart#empty"
  delete "/cart/:item_id", to: "cart#remove_item"

  resources :merchants do
    resources :items, only: [:index, :new, :create]
  end

  resources :items, only: [:index, :show, :edit, :update, :destroy] do
    resources :reviews, only: [:new, :create]
  end

  resources :reviews, only: [:edit, :update, :destroy]

  namespace :merchant do
    get "/", to: "dashboard#index"
    resources :items, only: [:index, :show, :update, :destroy]
    resources :orders, only: [:show]
    resources :item_orders, only: [:update]
  end

  namespace :admin do
    get "/", to: "dashboard#index"
    resources :merchants, only: [:index, :update, :show]
    resources :orders, only: [:update]
  end

  namespace :profile do
    get "/", to: "dashboard#index"
    resources :orders, only: [:index, :show, :destroy]
  end

  resources :orders, only: [:new, :create, :show]

  get "/profile/edit", to: "users#edit"
  patch "/profile", to: "users#update"
  get "/profile/edit_password", to: "users#edit_password"
  patch "/profile/edit_password", to: "users#update_password"
end
