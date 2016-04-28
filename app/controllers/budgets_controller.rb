class BudgetsController < ApplicationController
  def index
    @budgets = current_user.budgets
    render json: @budgets, status: :ok
  end
end
