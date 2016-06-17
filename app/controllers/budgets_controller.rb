class BudgetsController < ApplicationController
  def index
    @budgets = current_user.budgets
    render json: @budgets, status: :ok
  end

  # Updates multiple budgets at once:
  #   - receive JSON list
  #   - parse into array of budgets
  #   - update existing ones (positive IDs)
  #   - create new ones
  #   - render the updated list of budgets.
  def update
    budgets = update_budgets(params[:budgets])

    render json: budgets, status: :ok
  end

  private

  def update_budgets(budgets)
    updated_budgets = budgets.map do |b|
      budget = b[:id].to_i < 0 ? current_user.budgets.new : current_user.budgets.find(b[:id])
      budget.name = b[:name]
      budget.amount = b[:amount]
      budget.save # Poh about errors here, we've not validating anything to save time.

      budget
    end

    updated_budgets
  end
end
