Rails.application.routes.draw do
  root to: "multiwatch#home"

  get '/login', to: "sessions#new"
  post "/login", to: "session#create"
  delete "/logout", to: "session#destroy"

  get "multiwatch/home"
  get "multiwatch/watch"
  get "multiwatch/search_channel"
  resources :multiwatch, only: [:index]
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
