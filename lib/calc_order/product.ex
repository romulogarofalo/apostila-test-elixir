defmodule CalcOrder.Product do

  @type t :: %__MODULE__{
    name: String.t,
    value: integer(),
    amount: integer()
  }

  @enforce_keys [:name, :value, :amount]
  defstruct [:name, :value, :amount]
end
