defmodule CalcOrder.Client do

  @type t :: %__MODULE__{
    name: String.t,
    cep: String.t
  }

  @enforce_keys [:name, :cep]
  defstruct [:name, :cep]
end
