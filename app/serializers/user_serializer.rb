class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :week_fraction, :created_at, :currency

  def week_fraction
    0.5
  end

  def currency
    object.family.currency
  end
end
