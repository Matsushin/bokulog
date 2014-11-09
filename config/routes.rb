Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  resources :users, only: [:show] do
    resources :items, only: [:index, :create, :edit, :update]
  end

  resources :items, param: :asin, only: [:show] do
    collection do
      get 'search'
    end
  end

  root 'home#index'
end
