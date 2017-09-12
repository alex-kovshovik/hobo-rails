class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :api_key, :month_fraction, :created_at, :currency

  def month_fraction
    time = TimeService.new(object)

    month_start_time = time.month_start_time
    month_end_time = time.month_end_time

    (time.now - month_start_time) / (month_end_time - month_start_time)
  end

  def currency
    object.family.currency
  end
end
