Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "/sitters", to: "sitters#index", as: "sitters"
  get "/sitters/:id", to: "sitters#show", as: "sitter"
  post "/sitters/:id/requests", to: "requests#create", as: "user_requests"
  post "/owners/:id/animals", to: "animals#create", as: "new_animal"

  # patch "/requests/:id", to: "requests#update", as: "update_request"
  # get "/requests/:id/edit", to: "requests#edit", as: "edit_request"
  # get "/requests", to: "requests#index", as: "requests"
  # get "/requests/:id", to: "requests#show", as: "request"
  # get "/requests/:id/submit_confirm", to: "requests#submit_confirm", as: "submit_confirm"
  # get "/requests/:id/update_confirm", to: "requests#update_confirm", as: "update_confirm"
  # delete "/requests/:id", to: "requests#destroy"

  resources :animals, except: [:new, :create]
  resources :requests, only: [:index, :show, :update, :edit, :destroy] do
    resources :reviews, only: [:new, :create]
    member do
      get :submit_confirm
      get :update_confirm
    end
  end
  patch "/requests/:id", to: "requests#update", as: "update_request"
end
