Rails.application.routes.draw do
  root to: "multiwatch#home"

  get '/login', to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  resources :multiwatch, only: [:index] do
    collection do
      post "follow"
      delete "unfollow"
    end
  end
  get "multiwatch/home"
  get "multiwatch/watch"
  get "multiwatch/search_channel"


  resources :users do
    member do
      get "profile"
      get "security"
    end
  end

  resources :follow, only: [:new, :create, :destroy]

  namespace :api, format: "json" do
    namespace :v1 do
      resources :whispers, only: [:index, :create] do
        collection do
          delete "destroy"
        end
      end
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
