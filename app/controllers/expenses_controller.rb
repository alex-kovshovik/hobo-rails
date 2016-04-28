# Expenses resources
class ExpensesController < ApplicationController
  respond_to(:json)
  expose(:expense, attributes: :expense_params)

  def index
    @expenses = load_expenses.all
    render json: @expenses
  end

  def show
    @expense = load_expenses.find(params[:id])
    respond_with(@expense)
  end

  def create
    expense.save
    respond_with(expense)
  end

  def update
    @expense = load_expenses.find(params[:id])
    @expense.save!

    respond_with(@expense)
  end

  def destroy
    @expense = load_expenses.find(params[:id])
    @expense.destroy

    head :ok
  end

  private

  def load_expenses
    expenses = current_user.family.expenses
    expenses = expenses.where(budget_id: params[:budget_id]) if params[:budget_id]

    expenses
  end

  def expense_params
    params.require(:expense).permit(:budget_id, :amount, :comment)
  end
end
