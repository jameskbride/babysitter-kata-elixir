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
    end_time = start_time + hours
    before_bed_pay = calculate_before_bed_pay(start_time, end_time, bed_time)
    after_bed_pay = calculate_bed_time_pay(start_time, end_time, bed_time)
    after_midnight_pay = calculate_midnight_pay(end_time)

    before_bed_pay + after_bed_pay + after_midnight_pay
  end

  defp calculate_before_bed_time_hours(start_time, _, bed_time) when start_time >= bed_time do
    0
  end

  defp calculate_before_bed_time_hours(start_time, end_time, bed_time) when end_time <= bed_time do
    end_time - start_time
  end

  defp calculate_before_bed_time_hours(start_time, end_time, bed_time) when end_time > bed_time do
    bed_time - start_time
  end

  defp calculate_before_bed_pay(start_time, end_time, bed_time) do
    before_bed_hours = calculate_before_bed_time_hours(start_time, end_time, bed_time)
    before_bed_hours * @before_bed_rate
  end

  defp calculate_bed_time_hours(_, end_time, bed_time) when end_time <= bed_time do
    0
  end

  defp calculate_bed_time_hours(_, end_time, bed_time) when end_time > 24 do
    24 - bed_time
  end

  defp calculate_bed_time_hours(start_time, end_time, bed_time) when end_time <= 24 and start_time < bed_time do
    end_time - bed_time
  end

  defp calculate_bed_time_hours(start_time, end_time, bed_time) when start_time >= bed_time do
    end_time - start_time
  end

  defp calculate_bed_time_pay(start_time, end_time, bed_time) do
    after_bed_hours = calculate_bed_time_hours(start_time, end_time, bed_time)
    after_bed_hours * @after_bed_rate
  end

  defp calculate_after_midnight_hours(end_time) when rem(end_time, 24) < 5 do
    rem(end_time, 24)
  end

  defp calculate_after_midnight_hours(end_time) when rem(end_time, 24) >= 5 do
    0
  end

  defp calculate_midnight_pay(end_time) do
    calculate_after_midnight_hours(end_time) * @after_midnight_rate
  end
end
