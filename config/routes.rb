Rails.application.routes.draw do
  devise_for :users

  root to: 'home#index'

  # Authentication / registration
  post 'auth/register', to: 'auth#register'
  post 'auth/check', to: 'auth#check'

  # Main application
  resources :budgets, only: :index do
    resources :expenses
  end

  resources :expenses, only: :index
end
