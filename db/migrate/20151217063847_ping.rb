class Ping < ActiveRecord::Migration
  def change
    create_table :pings do |t|
      t.string :origin
      t.integer :name_lookup_time_ms
      t.integer :connect_time_ms
      t.integer :transfer_time_ms
      t.integer :total_time_ms
      t.datetime :created_at
      t.integer :status
    end

    add_index :pings, [:origin, :created_at], unique: true


    create_table :ping_aggregates do |t|
      t.string :origin
      t.datetime :hourly # DateTime with 00:00 as minutes and seconds
      t.integer :transfer_time_sum, default: 0
      t.integer :transfer_time_count, default: 0
      t.integer :transfer_time_avg
      t.integer :lock_version, default: 0 # to detect race condition
    end

    add_index :ping_aggregates, [:origin, :hourly], unique: true
  end
end
