Rails.application.routes.draw do
  devise_for :users
  root to: 'landings#index'

  namespace :api do
    resources :books, only: [:new, :create]
  end

  namespace :api, format: 'json' do
    resources :books, only: [:index, :show]
  end

  resources :pages, only: [:index]
end
