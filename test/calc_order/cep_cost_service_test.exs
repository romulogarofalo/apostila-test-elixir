defmodule CalcOrder.CepCostServiceTest do
	use ExUnit.Case

	import Mox
	alias CalcOrder.CepCostService

	describe "calc_ship" do
		test "" do
			response_body = %{
        "value" => 20
      }

			expect(Tesla.Mock, :call, fn %Tesla.Env{
        method: :get,
      } = env, _ ->
        {:ok, %Tesla.Env{env | status: 200, body: response_body}}
      end)

			assert CepCostService.calc_ship("11211234") == {:ok, ship_cost: 20}
		end
		test "cep not found" do
			expect(Tesla.Mock, :call, fn %Tesla.Env{
        method: :get,
      } = env, _ ->
        {:ok, %Tesla.Env{env | status: 200, body: %{"error" => "invalid cep"}}}
      end)

			assert CepCostService.calc_ship("11211234") == {:error, :invalid_cep}
		end
		test "not found error" do
			expect(Tesla.Mock, :call, fn %Tesla.Env{
        method: :get,
      } = env, _ ->
        {:ok, %Tesla.Env{env | status: 404}}
      end)

			assert CepCostService.calc_ship("11211234") == {:error, :not_found}
		end
		test "timeout error" do
			expect(Tesla.Mock, :call, fn %Tesla.Env{
        method: :get,
      } = env, _ ->
        {:ok, %Tesla.Env{env | status: 408}}
      end)

			assert CepCostService.calc_ship("11211234") == {:error, :timeout}
		end
	end
end
