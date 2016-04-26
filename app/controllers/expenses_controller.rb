# Expenses resources
class ExpensesController < ApplicationController
  respond_to(:json)
  expose(:expense, attributes: :expense_params)

  def index
    expenses = Expense.all
    render json: expenses
  end

  def show
    respond_with(expense)
  end

  def create
    expense.save
    respond_with(expense)
  end

  def update
  end

  def destroy
    expense.destroy
    head :ok
  end

  private

  def expense_params
    params.require(:expense).permit(:budget_id, :amount, :comment)
  end
end
