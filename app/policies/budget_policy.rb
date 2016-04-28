class BudgetPolicy
  attr_reader :user, :budget

  def initialize(user, budget)
    @user = user
    @budget = budget
  end

  def show?
    @budget.in? user.budgets
  end
end
