defmodule BabySitterTest do
  use ExUnit.Case

  describe "when start time is before bed time" do
    test "then it can calculate pay for an hour" do
      assert BabySitter.calculate_pay(17, 1, 18) == {:ok, 12}
    end

    test "then it can calculate pay for multiple hours" do
      assert BabySitter.calculate_pay(17, 2, 19) == {:ok, 24}
    end
  end

  describe "when and end time is at least one hour before bed time" do
    test "then it can calculate pay" do
      assert BabySitter.calculate_pay(17, 2, 20) == {:ok, 24}
    end
  end

  describe "when end time is after bed time" do
    test "then it can calculate pay" do
      assert BabySitter.calculate_pay(17, 2, 18) == {:ok, 20}
    end
  end

  describe "when start time and bed time are the same" do
    test "then it can calculate pay" do
      assert BabySitter.calculate_pay(17, 2, 17) == {:ok, 16}
    end
  end

  describe "when start time is before bed time and end time is after midnight" do
    test "then it can calculate pay" do
      assert BabySitter.calculate_pay(22, 3, 23) == {:ok, 36}
    end
  end

  describe "when start time is before 5:00PM" do
    test "then an error is returned" do
      assert BabySitter.calculate_pay(16, 1, 18) == {:error, "Babysitter cannot start before 5:00PM"}
    end
  end

  describe "when end time is after 4:00AM" do
    test "then starting before midnight returns an error" do
      assert BabySitter.calculate_pay(17, 12, 18) == {:error, "Babysitter must leave by 4:00AM"}
    end

    test "then starting at midnight returns an error" do
      assert BabySitter.calculate_pay(0, 5, 1) == {:error, "Babysitter must leave by 4:00AM"}
    end

    test "then starting after midnight returns an error" do
      assert BabySitter.calculate_pay(1, 5, 2) == {:error, "Babysitter must leave by 4:00AM"}
    end
  end
end
