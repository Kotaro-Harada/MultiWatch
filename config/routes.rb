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
          post "invite_chat"
        end
      end
    end
  end

  resources :rooms, only: [:index, :create, :destroy] do
    collection do
      get "get_participants"
      post "add_user"
      delete "delete_user"
    end
  end

  resources :chat, only: [:index, :create, :destroy]

  resources :friendship do
    collection do
      get "get_active_friends"
      get "get_passive_friends"
    end
  end

  resources :user_room do
    collection do
      delete "destroy"
    end
  end

  mount ActionCable.server => '/cable'
end
