Rails.application.routes.draw do
  root to: "multiwatch#home"

  get '/login', to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  get "multiwatch/home"
  get "multiwatch/watch"
  get "multiwatch/search_channel"
  resources :multiwatch, only: [:index]

  resources :users do
    member do
      get "profile"
      get "security"
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
