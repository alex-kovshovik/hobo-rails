class TimeService
  def initialize(user)
    @timezone = user.family.timezone
    # @now_utc = DateTime.now.utc
  end

  def week_start_time
    d = Date.today.beginning_of_week
    Time.new(d.year, d.month, d.day, 0, 0, 0)
  end

  def week_end_time
    d = Date.today.end_of_week
    Time.new(d.year, d.month, d.day, 23, 59, 59)
  end

  def now
    Time.now
  end
end
