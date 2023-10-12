Rails.application.routes.draw do
  # Devise configration
  devise_for :users

  get '/users/list', to: 'users#index'

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  resources :books
  root to: 'books#index'
end
