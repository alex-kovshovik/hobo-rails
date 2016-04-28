class ExpenseSerializer < ActiveModel::Serializer
  attributes :id, :budget_id, :amount, :comment, :created_at, :errors

  def errors
    object.errors.full_messages.join(', ')
  end
end
