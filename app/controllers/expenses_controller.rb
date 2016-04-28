# Expenses resources
class ExpensesController < ApplicationController
  before_action :load_budget, only: %i(show create update destroy)
  before_action :load_expense, only: %i(show update destroy)

  # Index is special: it could either render all user's expenses
  # with all specified filters applied, or it could render just
  # expenses within a specific budget.
  def index
    @expenses = find_expenses.all
    render json: @expenses
  end

  def show
    render json: @expense, status: :ok
  end

  def create
    @expense = Expense.new(expense_params)
    @expense.budget = @budget

    status = @expense.save ? :ok : :unprocessable_entity
    render json: @expense, status: status
  end

  def update
    status = @expense.update_attributes(expense_params) ? :ok : :unprocessable_entity
    render json: @expense, status: status
  end

  def destroy
    @expense.destroy

    head :ok
  end

  private

  def load_budget
    @budget = current_user.budgets.find(params[:budget_id])
  end

  def load_expense
    @expense = @budget.expenses.find(params[:id])
  end

  def find_expenses
    expenses = current_user.expenses
    expenses = expenses.where(budget_id: params[:budget_id]) if params[:budget_id]

    expenses
  end

  def expense_params
    params.require(:expense).permit(:amount, :comment)
  end
end
