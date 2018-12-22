defmodule BabySitter do

  alias BabySitter.ScheduleValidation, as: ScheduleValidation

  @before_bed_rate 12
  @after_bed_rate 8

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
    after_bed_hours = end_time - bed_time
    after_bed_pay = after_bed_hours * @after_bed_rate

    before_bed_pay + after_bed_pay
  end
end
