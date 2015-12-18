class Ping < ActiveRecord::Base

  # rescue Duplicate key error
  # @return PingAggregate
  def ping_aggregate
    begin
      PingAggregate.where(origin: self.origin, hourly: hourly).first_or_create!
    rescue ActiveRecord::RecordNotUnique => ar_rnu
      Rails.logger.debug ar_rnu
      # MySQL error Duplicate entry ... for key ... in case of concurrent INSERT
      PingAggregate.where(origin: self.origin, hourly: hourly).first
    end
  end

  private

  def hourly
    @hourly ||= truncate_hour(self.created_at)
  end

  # @param  DateTime  a datetime
  # @return DateTime  the datetime without minutes or seconds
  def truncate_hour(date_time)
    DateTime.new(date_time.year, date_time.month, date_time.day, date_time.hour)
  end

end
