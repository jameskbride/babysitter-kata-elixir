defmodule BabySitter.AfterMidnight do
  @after_midnight_rate 16

  def calculate_midnight_pay(end_time) do
    calculate_after_midnight_hours(end_time) * @after_midnight_rate
  end

  defp calculate_after_midnight_hours(end_time) when rem(end_time, 24) < 5 do
    rem(end_time, 24)
  end

  defp calculate_after_midnight_hours(end_time) when rem(end_time, 24) >= 5 do
    0
  end
end