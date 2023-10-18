Rails.application.routes.draw do
  get 'comments/new'
  get 'comments/index'
  get 'comments/create'
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  devise_for :users
  root to: 'books#index'
  resources :books
  resources :reports
  resources :comments
  resources :users, only: %i(index show)
end
