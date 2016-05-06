class ExpenseSerializer < ActiveModel::Serializer
  attributes :id, :budget_id, :budget_name, :amount, :comment,
             :created_by, :created_by_name, :created_at, :errors

  def budget_name
    object.budget.name
  end

  def errors
    object.errors.full_messages.join(', ')
  end

  def created_by_name
    user = User.find_by(id: object.created_by)
    user.nil? ? "" : user.first_name
  end
end
