defmodule CalcOrder.CepCostService do


  @spec calc_ship(cep :: String.t()) ::
    {:ok, %{ship_cost: Integer.t, total_cart: Integer.t}} |
    {:error, :invalid_cep | :not_found | :timeout}
  def calc_ship(cep) do
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

  defp client() do
    middleware = [
      {Tesla.Middleware.BaseUrl, ""},
    ]

    adapter = {Application.fetch_env!(:tesla, :adapter), [pool: :apostila]}
    Tesla.client(middleware, adapter)
  end
end
