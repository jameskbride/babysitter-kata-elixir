defmodule BabySitterTest do
  use ExUnit.Case
  doctest BabySitter

  test "greets the world" do
    assert BabySitter.hello() == :world
  end
end
