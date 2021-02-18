Rails.application.routes.draw do
  devise_for :users
  root to: 'landings#index'

  namespace :api do
    resources :books, only: [:index, :new, :create]
  end
end
