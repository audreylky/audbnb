Rails.application.routes.draw do
  # get 'braintree/new'
  get 'payment' => 'braintree#new'
  # post 'braintree/checkout'

  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  # resource :session, controller: "clearance/sessions", only: [:create]
  resource :session, controller: "sessions", only: [:create]

#####################
  resources :users, controller: "users", only: [:show, :edit, :update, :destroy]
  resources :users, controller: "users", only: [:create] do
    resource :password,  #no id
      controller: "clearance/passwords",
      only: [:create, :edit, :update]
  end

  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"
  get "/sign_up" => "clearance/users#new", as: "sign_up"


  root 'pages#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get "/auth/:provider/callback" => "sessions#create_from_omniauth"

#####################
  resources :tags
  resources :listings
  resources :listings, only: [:show] do
    resources :reservations,
    only: [:index, :show, :new, :create, :edit, :update, :delete] do
      resources :payment, controller: 'braintree', only: [:new, :create]
    end
  end
end
