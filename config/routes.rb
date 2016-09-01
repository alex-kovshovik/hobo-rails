Rails.application.routes.draw do
  # Authentication / registration
  post 'auth/register', to: 'auth#register'
  post 'auth/check', to: 'auth#check'

  # Main application
  resources :budgets, only: [:index, :destroy] do
    resources :expenses
    post :update, on: :collection
  end

  resources :expenses, only: [:index, :show, :destroy]
end
