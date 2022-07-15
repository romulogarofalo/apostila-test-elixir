defmodule CalcOrder.ShipCost do

  alias CalcOrder.Cart
  alias CalcOrder.CepCostService

  @spec calc_cart_ship(Cart.t()) ::
    {:ok, %{ship_cost: Integer.t, total_cart: Integer.t}} |
    {:error, :invalid_cep | :not_found | :timeout}
  def calc_cart_ship(cart) do
    with total_cart <- sum_cart(cart),
      {:ok, ship_cost: ship_cost} <- ship_cost(total_cart, cart) do
      {:ok, %{ship_cost: ship_cost, total_cart: total_cart}}
    end
  end

  def sum_cart(%Cart{products: products}) do
    products
    |> Enum.reduce(0, fn %{
        amount: amount,
        value: value
      }, acc ->
      acc + (value * amount)
    end)
  end

  def ship_cost(amount, %{client: %{cep: cep}}) when amount < 100 do
    CepCostService.calc_ship(cep)
  end

  def ship_cost(_amount, _), do: {:ok, ship_cost: 0}
end
