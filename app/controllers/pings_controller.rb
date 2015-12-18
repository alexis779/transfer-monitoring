class PingsController < ApplicationController
  def transfer_chart
  end

  def create
    render json: Pings::Creator.new.create(params.permit(:origin, :name_lookup_time_ms, :connect_time_ms, :transfer_time_ms, :total_time_ms, :created_at, :status))
  end

  # String  origin
  # Fixnum  offset
  # Fixnum  limit
  def hours
    render json: Pings::Selector.new.hours(params)
  end

  def origins
    render json: Pings::Selector.new.origins
  end
end
