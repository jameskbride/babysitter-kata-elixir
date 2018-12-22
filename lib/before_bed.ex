defmodule BabySitter.BeforeBed do
  @before_bed_rate 12

  def calculate_before_bed_pay(start_time, end_time, bed_time) do
    before_bed_hours = calculate_before_bed_time_hours(start_time, end_time, bed_time)
    before_bed_hours * @before_bed_rate
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


end