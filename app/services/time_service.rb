class TimeService
  def initialize(user)
    @timezone = user.family.timezone
  end

  def month_start_time
    d = Date.today.beginning_of_month
    Time.new(d.year, d.month, d.day, 0, 0, 0)
  end

  def month_end_time
    d = Date.today.end_of_month
    Time.new(d.year, d.month, d.day, 23, 59, 59)
  end

  def now
    Time.current
  end
end
