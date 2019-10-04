defmodule InfluxKapacitorTest do
  use ExUnit.Case
  doctest InfluxKapacitor

  test "greets the world" do
    assert InfluxKapacitor.hello() == :world
  end
end
