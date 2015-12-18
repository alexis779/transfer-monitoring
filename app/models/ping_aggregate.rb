class PingAggregate < ActiveRecord::Base
  before_save :update_avg

  # rescue Concurrency error
  def add_transfer_time(transfer_time_ms)
    begin
      self.transfer_time_sum += transfer_time_ms
      self.transfer_time_count += 1
      self.save!
    rescue ActiveRecord::StaleObjectError => ar_se
      # Lock version loaded during Select is stale
      Rails.logger.debug ar_se

      # Fetch last version
      self.reload
      retry
    end
  end

  def data_point
    [
      self.hourly.to_i * 1000, # convert timestamp into milliseconds for Highcharts
      self.transfer_time_avg.to_i
    ]
  end

  private

  def update_avg
    self.transfer_time_avg = self.transfer_time_sum.to_f / self.transfer_time_count
  end

end
