defmodule BabySitterTest do
  use ExUnit.Case

  describe "before bedtime" do
    test "one hour of work" do
      assert BabySitter.calculate_pay(17, 1, 18) == 12
    end
  end
end
