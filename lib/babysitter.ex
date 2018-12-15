defmodule BabySitter do

  @earliest_start_time 17
  @early_hourly_rate 12
  @too_early_message "Babysitter cannot start before 5:00PM"
  @too_late_message "Babysitter must leave by 4:00AM"

  def calculate_pay(start_time, hours, _bed_time) do
    cond do
      start_time < @earliest_start_time -> {:error, @too_early_message}
      start_time + hours > 28 -> {:error, @too_late_message}
      true -> {:ok, @early_hourly_rate * hours}
    end
  end
end
