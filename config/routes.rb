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

  resources :follow, only: [:index, :new, :create] do
    collection do
      get "check"
      delete "destroy"
      get "image"
      get "get_stream"
    end
  end

  namespace :api, format: "json" do
    namespace :v1 do
      resources :whispers, only: [:index, :create] do
        collection do
          delete "destroy"
          post "friend_request"
        end
      end
    end
  end

  resources :friendship, only: [:show, :create, :destroy]
end
