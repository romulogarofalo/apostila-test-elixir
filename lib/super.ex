defmodule Super do
  use DynamicSupervisor

  alias SupFlow

  def start_link() do
    DynamicSupervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  def start_child() do
    # If MyWorker is not using the new child specs, we need to pass a map:
    spec = %{id: SupFlow, start: {SupFlow, :start_link, []}}
    # spec = {SupFlow, []}
    DynamicSupervisor.start_child(__MODULE__, spec)
  end

  @impl true
  def init(_) do
    DynamicSupervisor.init(
      strategy: :one_for_one
    )
  end
end
