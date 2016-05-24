class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :week_fraction, :created_at, :currency

  def week_fraction
    time = TimeService.new(object)

    week_start_time = time.week_start_time
    week_end_time = time.week_end_time

    (time.now - week_start_time) / (week_end_time - week_start_time)
  end

  def currency
    object.family.currency
  end
end
