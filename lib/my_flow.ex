defmodule MyFlow do
  # alias Flow
  require Logger
  alias Super

  defdelegate map(flow, mapper), to: Flow
  defdelegate filter(flow, filter), to: Flow
  defdelegate run(flow), to: Flow

  def execute() do
    Super.start_link()
    Super.start_child()
  end

  def start_link() do
    start_link({})
  end

  def start_link(_) do
    1..1000
    |> Flow.from_enumerable()
    |> Flow.map(fn x ->
      IO.inspect("aaa #{x}")
      Process.sleep(1000)
    end)
    |> Flow.start_link()
  end
end
