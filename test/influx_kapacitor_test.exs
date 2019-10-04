defmodule InfluxKapacitorTest do
  use ExUnit.Case
  doctest InfluxKapacitor

  setup do
    registry = start_supervised!(InfluxRecorder)
    %{registry: registry}
  end

  test "insert item" do
    q = :queue.new()

    IO.inspect(
      :queue.in(%{k: "key", m: "foo", t: ~U[2019-10-04 01:02:25.319989Z], v: "value"}, q)
    )

    InfluxRecorder.record("foo", "key", "value")
    :timer.sleep(100)
    IO.inspect(InfluxRecorder.get_queue())
  end
end
