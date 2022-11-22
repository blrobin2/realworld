# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  scope :api do
    devise_for :users,
      defaults: { format: :json },
      path_names: {
        sign_in: :login
      }

    resource :user, only: [:show, :update]
    resources :profiles,
      param: :username,
      constraints: { username: /[0-9A-Za-z\-\.\_]+/ },
      only: [:show] do
        member do
          post 'follow', action: :follow
          delete 'follow', action: :unfollow
        end
      end
  end
end
