defmodule BabySitter do

  alias BabySitter.ScheduleValidation, as: ScheduleValidation

  @before_bed_rate 12
  @after_bed_rate 8
  @after_midnight_rate 16

  @too_early_message "Babysitter cannot start before 5:00PM"
  @too_late_message "Babysitter must leave by 4:00AM"

  def calculate_pay(start_time, hours, bed_time) do
    cond do
      ScheduleValidation.end_time_too_late?(start_time, hours) -> {:error, @too_late_message}
      ScheduleValidation.start_time_too_early?(start_time) -> {:error, @too_early_message}
      true -> {:ok, calculate_by_pay_rate(start_time, hours, bed_time)}
    end
  end

  defp calculate_by_pay_rate(start_time, hours, bed_time) do
    before_bed_hours = bed_time - start_time
    before_bed_pay = before_bed_hours * @before_bed_rate

    end_time = start_time + hours
    after_bed_hours = calculate_bedtime_hours(end_time, bed_time)
    after_bed_pay = after_bed_hours * @after_bed_rate

    after_midnight_pay = calculate_after_midnight_hours(end_time) * @after_midnight_rate

    before_bed_pay + after_bed_pay + after_midnight_pay
  end

  defp calculate_bedtime_hours(end_time, bedtime) when end_time > 24 do
    24 - bedtime
  end

  defp calculate_bedtime_hours(end_time, bedtime) when end_time <= 24 do
    end_time - bedtime
  end

  defp calculate_after_midnight_hours(end_time) when rem(end_time, 24) < 5 do
    rem(end_time, 24)
  end

  defp calculate_after_midnight_hours(end_time) when rem(end_time, 24) >= 5 do
    0
  end
end
