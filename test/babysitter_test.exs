defmodule BabySitterTest do
  use ExUnit.Case

  describe "before bedtime" do
    test "can calculate pay for an hour" do
      assert BabySitter.calculate_pay(17, 1, 18) == {:ok, 12}
    end

    test "can calculate pay for multiple hours" do
      assert BabySitter.calculate_pay(17, 2, 19) == {:ok, 24}
    end

    test "end time is at least one hour before bedtime" do
      assert BabySitter.calculate_pay(17, 2, 20) == {:ok, 24}
    end
  end

  describe "bedtime" do
    test "before and after bedtime can calculate pay" do
      assert BabySitter.calculate_pay(17, 2, 18) == {:ok, 20}
    end

    test "start time and bedtime are the same can calculate pay" do
      assert BabySitter.calculate_pay(17, 2, 17) == {:ok, 16}
    end
  end

  describe "midnight" do
    test "before bedtime, after bedtime, and past midnight can calculate pay" do
      assert BabySitter.calculate_pay(22, 3, 23) == {:ok, 36}
    end
  end

  describe "starting before 5:00PM" do
    test "returns an error" do
      assert BabySitter.calculate_pay(16, 1, 18) == {:error, "Babysitter cannot start before 5:00PM"}
    end
  end

  describe "leaving after 4:00AM" do
    test "starting before midnight returns an error" do
      assert BabySitter.calculate_pay(17, 12, 18) == {:error, "Babysitter must leave by 4:00AM"}
    end

    test "starting at midnight returns an error" do
      assert BabySitter.calculate_pay(0, 5, 1) == {:error, "Babysitter must leave by 4:00AM"}
    end

    test "starting after midnight returns an error" do
      assert BabySitter.calculate_pay(1, 5, 2) == {:error, "Babysitter must leave by 4:00AM"}
    end
  end
end
