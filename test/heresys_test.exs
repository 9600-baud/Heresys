defmodule HeresysTest do
  use ExUnit.Case
  doctest Heresys

  test "greets the world" do
    assert Heresys.hello() == :world
  end
end
