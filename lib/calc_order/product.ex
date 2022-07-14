defmodule CalcOrder.Product do

  @type t :: %__MODULE__{
    name: String.t,
    value: integer()
  }

  @enforce_keys [:name, :value]
  defstruct [:name, :value]
end
