defmodule CalcOrder.Cart do
  alias CalcOrder.Product

  @type t :: %__MODULE__{
    product: Product.t,
    amount: integer()
  }

  @enforce_keys [:product, :amount]
  defstruct [:product, :amount]
end
