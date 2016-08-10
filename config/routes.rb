Rails.application.routes.draw do
  devise_for :users, :controllers => {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  namespace :member do
    root 'sessions#index'
    resources :sessions, only: [:index, :new] do
      post :create_session, :create_user, on: :collection
    end
    resources :users, only: [:edit, :update]
  end
end
