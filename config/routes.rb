Rails.application.routes.draw do
  resources :expenses
  resources :expens
  devise_for :users

  root to: 'home#index'

  post 'auth/register', to: 'auth#register'
  post 'auth/check', to: 'auth#check'

  resources :budgets
  resources :expenses
end
