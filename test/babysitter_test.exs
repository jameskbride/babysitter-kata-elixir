defmodule BabySitterTest do
  use ExUnit.Case

  describe "before bedtime" do
    test "one hour of work pays $12" do
      assert BabySitter.calculate_pay(17, 1, 18) == {:ok, 12}
    end

    test "two hours of work pays $24" do
      assert BabySitter.calculate_pay(17, 2, 19) == {:ok, 24}
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

  describe "bedtime before midnight" do
    test "one hour of works pays $8" do
      assert BabySitter.calculate_pay(17, 2, 18) == {:ok, 20}
    end
  end
end
