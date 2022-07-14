defmodule CalcOrder.Cart do
  alias CalcOrder.Product
  alias CalcOrder.Client

  @type t :: %__MODULE__{
    products: [Product.t],
    client: Client.t()
  }

  @enforce_keys [:products, :client]
  defstruct [:products, :client]
end
