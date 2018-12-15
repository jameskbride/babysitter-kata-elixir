defmodule BabySitter do

  def calculate_pay(start_time, hours, _bed_time) do
    cond do
      start_time < 17 -> {:error, "Babysitter cannot start before 5:00PM"}
      true -> 12 * hours
    end
  end
end
