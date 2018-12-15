defmodule BabySitter do

  @earliest_start_time 17
  @early_hourly_rate 12

  def calculate_pay(start_time, hours, _bed_time) do
    cond do
      start_time < @earliest_start_time -> {:error, "Babysitter cannot start before 5:00PM"}
      true -> @early_hourly_rate * hours
    end
  end
end
