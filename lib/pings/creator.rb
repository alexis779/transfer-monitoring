module Pings
  class Creator

    def create(options)
      update_aggregate(Ping.create!(options))
    end

    def import(ping_file)
      parse_json(ping_file).each { |ping|
        create(ping)
      }
    end

    def print_inserts(ping_file)
      parse_json(ping_file).each_slice(100) { |slice|
        print batch_insert(slice)
      }
    end

    private

    def update_aggregate(ping)
      ping.ping_aggregate.add_transfer_time(ping.transfer_time_ms)

      ping
    end

    def parse_json(ping_file)
      JSON.parse(open(ping_file).read, symbolize_names: true)
    end

    def batch_insert(slice)
      insert = ""

      insert << "INSERT INTO pings(origin, name_lookup_time_ms, connect_time_ms, transfer_time_ms, total_time_ms, created_at, status) VALUES "
      insert << slice.map { |options|
        "('#{options[:origin]}', #{options[:name_lookup_time_ms]}, #{options[:connect_time_ms]}, #{options[:transfer_time_ms]}, #{options[:total_time_ms]}, '#{options[:created_at]}', #{options[:status]})"
      }.join(",\n")
      insert << ";\n"

      insert
    end
  end
end
