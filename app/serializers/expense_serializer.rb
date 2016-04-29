class ExpenseSerializer < ActiveModel::Serializer
  attributes :id, :budget_id, :budget_name, :amount, :comment, :created_at, :errors

  def budget_name
    object.budget.name
  end

  def errors
    object.errors.full_messages.join(', ')
  end
end
