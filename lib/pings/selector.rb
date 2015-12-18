module Pings
  class Selector
    def hours(options)
      PingAggregate.where(origin: options[:origin]).offset(options[:offset]).limit(options[:limit]).order("hourly ASC").map(&:data_point)
    end

    def origins
      PingAggregate.group("origin").pluck("origin")
    end
  end
end
