defmodule BabySitter.ScheduleValidation do

  @earliest_start_time 17
  @latest_end_time 4

  def end_time_too_late?(start_time, hours) do
    end_time_24_hours = rem(start_time + hours, 24)
    end_time_24_hours > @latest_end_time and end_time_24_hours < @earliest_start_time
  end

  def start_time_too_early?(start_time) do
    start_time < @earliest_start_time
  end
end