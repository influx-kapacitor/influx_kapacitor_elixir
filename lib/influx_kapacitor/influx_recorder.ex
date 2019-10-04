defmodule InfluxRecorder do
  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, :queue.new(), name: __MODULE__)
  end

  def init(queue) do
    {:ok, queue}
  end

  def record(measurement, key, value, timestamp \\ DateTime.utc_now()) do
    GenServer.cast(
      __MODULE__,
      {:record, %{m: measurement, k: key, v: value, t: timestamp}}
    )
  end

  def get_queue() do
    GenServer.call(__MODULE__, :get_queue)
  end

  def handle_call(:get_queue, _from, queue) do
    {:reply, queue, :queue.new()}
  end

  def handle_cast({:record, measurement}, queue) do
    {:noreply, :queue.in(measurement, queue)}
  end
end
