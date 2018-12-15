defmodule BabySitterTest do
  use ExUnit.Case

  describe "before bedtime" do
    test "one hour of work" do
      assert BabySitter.calculate_pay(17, 1, 18) == 12
    end

    test "two hours of work" do
      assert BabySitter.calculate_pay(17, 2, 19) == 24
    end
  end

  describe "before 5:00PM" do
    test "returns an error" do
      assert BabySitter.calculate_pay(16, 1, 18) == {:error, "Babysitter cannot start before 5:00PM"}
    end
  end
end
