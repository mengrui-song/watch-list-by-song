Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root to: 'lists#index'
  devise_scope :user do
    authenticated :user do
      root 'lists#index', as: :authenticated_root
    end

    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end

  resources :lists, only: %i[index show new create destroy] do
    resources :bookmarks, only: %i[new create show] do
      resources :movies, only: [:create]
    end
  end

  resources :movies, only: [:show] do
    resources :bookmarks, only: %i[new create]
    resources :people, only: [:index]
  end

  resources :people, only: [:show] do
    resources :bookmarks, only: %i[new create]
  end
  # resources :movies, only: [:show]

  resources :bookmarks, only: [:destroy]

end
