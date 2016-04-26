class ExpenseSerializer < ActiveModel::Serializer
  attributes :id, :budget, :budget_id, :amount, :comment

  def budget
    object.budget.name
  end
end
