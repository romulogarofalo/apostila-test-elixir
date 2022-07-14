defmodule CalcOrder.ShipCost do

  alias CalcOrder.Cart

  @spec calc_cart_ship(Cart.t()) ::
    {:ok, %{ship_cost: Integer.t, total_cart: Integer.t}} |
    {:error, :invalid_cep | :not_found | :timeout}
  def calc_cart_ship(cart) do
    with total_cart <- sum_cart(cart),
    IO.inspect(total_cart),
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
    client()
    |> Tesla.get("/correios", query: [cep: cep])
    |> case do
      {:ok, %{body: %{"value" => ship_cost}}} ->
        {:ok, ship_cost: ship_cost}
      {:ok, %{body: %{"error" => "invalid cep"}}} ->
        {:error, :invalid_cep}
      {:ok, %{status: 404}} ->
        {:error, :not_found}
      {:ok, %{status: 408}} ->
        {:error, :timeout}
      result -> result
    end
  end

  def ship_cost(_amount, _), do: {:ok, ship_cost: 0}

  defp client() do
    middleware = [
      {Tesla.Middleware.BaseUrl, ""},
    ]

    adapter = {Application.fetch_env!(:tesla, :adapter), [pool: :apostila]}
    IO.inspect(adapter)
    Tesla.client(middleware, adapter)
  end
end
