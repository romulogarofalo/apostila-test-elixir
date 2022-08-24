defmodule SupFlow do
  use Supervisor

  alias MyFlow

  def start_link() do
    Supervisor.start_link(__MODULE__, :ok)
  end

  def init(:ok) do
    Supervisor.init(
      [worker(MyFlow, [], restart: :transient)],
      [strategy: :one_for_all,
      max_restarts: 0]
    )
  end
end
