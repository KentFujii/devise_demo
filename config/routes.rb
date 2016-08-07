Rails.application.routes.draw do
  devise_for :users, :controllers => {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  namespace :member do
    root 'sessions#new'
    resource :session, only: [:create, :destroy]
    resources :users
  end
end
