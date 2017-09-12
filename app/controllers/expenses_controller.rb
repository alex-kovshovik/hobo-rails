# Expenses resources
class ExpensesController < ApplicationController
  before_action :load_expense, only: %i(show update)

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
    @expense.budget = load_budget

    status = @expense.save ? :ok : :unprocessable_entity
    render json: @expense, status: status
  end

  def update
    status = @expense.update_attributes(expense_params) ? :ok : :unprocessable_entity
    render json: @expense, status: status
  end

  def destroy
    @expense = find_expenses.where(id: params[:id]).first

    if @expense
      @expense.destroy
      render json: @expense, status: :ok
    else
      head :not_found
    end
  end

  private

  def load_budget
    @budget = current_user.budgets.find(params[:budget_id])
  end

  def load_expense
    base_relation =
      if params[:budget_id]
        budget = load_budget
        budget.expenses
      else
        current_user.expenses
      end

    @expense = base_relation.find(params[:id])
  end

  def find_expenses
    expenses = current_user.expenses.order(created_at: :desc)
    expenses = expenses.where(budget_id: params[:budget_id]) if params[:budget_id]


    if params[:month]
      month = params[:month].to_i
      time_service = TimeService.new(current_user)

      month_start_time = time_service.month_start_time
      month_end_time = time_service.month_end_time

      # month param is a negative number darn it
      start_time = month_start_time + month.months
      end_time = month_end_time + month.months

      expenses = expenses.where('expenses.created_at between ? and ?', start_time, end_time)
    end

    expenses
  end

  def expense_params
    params.require(:expense).permit(:amount, :comment)
  end
end
