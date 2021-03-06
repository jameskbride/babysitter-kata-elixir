defmodule BabySitter do

  alias BabySitter.ScheduleValidation, as: ScheduleValidation
  alias BabySitter.BeforeBedTime, as: BeforeBedTime
  alias BabySitter.Bedtime, as: BedTime
  alias BabySitter.AfterMidnight, as: AfterMidnight

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
    before_bed_pay = BeforeBedTime.calculate_before_bed_pay(start_time, end_time, bed_time)
    after_bed_pay = BedTime.calculate_bed_time_pay(start_time, end_time, bed_time)
    after_midnight_pay = AfterMidnight.calculate_midnight_pay(end_time)

    before_bed_pay + after_bed_pay + after_midnight_pay
  end
end
