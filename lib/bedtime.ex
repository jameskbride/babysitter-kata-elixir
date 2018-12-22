defmodule BabySitter.Bedtime do
  @after_bed_rate 8

  def calculate_bed_time_pay(start_time, end_time, bed_time) do
    after_bed_hours = calculate_bed_time_hours(start_time, end_time, bed_time)
    after_bed_hours * @after_bed_rate
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
end