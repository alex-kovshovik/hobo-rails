class BudgetSerializer < ActiveModel::Serializer
  attributes :id, :name, :amount, :created_at, :errors

  def errors
    object.errors.full_messages.join(', ')
  end
end
