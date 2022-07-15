defmodule CalcOrder.ShipCostTest do
	use ExUnit.Case

  import Mox

  alias CalcOrder.ShipCost
  alias CalcOrder.Cart
  alias CalcOrder.Product
  alias CalcOrder.Client
  alias CalcOrder.CepCostService

  describe "calc_cart_ship" do
    test "calc_cart_ship with right params" do
      cart =
        %Cart{
          products: [
            %Product{
              name: "banana",
              value: 10,
              amount: 4
            },
            %Product{
              name: "laranja",
              value: 2,
              amount: 4
            },
            %Product{
              name: "morango",
              value: 20,
              amount: 2
            },
          ],
          client: %Client{
            name: "romulo",
            cep: "11233234"
          }
        }

      response_body = %{
        "value" => 20
      }

      expect(Tesla.Mock, :call, fn %Tesla.Env{
        method: :get,
      } = env, _ ->
        {:ok, %Tesla.Env{env | status: 200, body: response_body}}
      end)

      assert ShipCost.calc_cart_ship(cart) ==
        {:ok, %{ship_cost: 20, total_cart: 88}}

    end

    test "sum_cart with no products" do
      expect(Tesla.Mock, :call, fn %Tesla.Env{
          method: :get,
        } = env, _ ->
          {:ok, %Tesla.Env{env | status: 200, body: %{
            "value" => 20
          }}}
      end)

      assert ShipCost.calc_cart_ship(%Cart{products: [],
      client: %Client{
        name: "romulo",
        cep: "11233234"
      }}) == {:ok, %{ship_cost: 20, total_cart: 0}}
    end

    test "sum_cart total bigger than 100" do
      cart =
        %Cart{
          products: [
            %Product{
              name: "banana",
              value: 10,
              amount: 4
            },
            %Product{
              name: "laranja",
              value: 2,
              amount: 4
            },
            %Product{
              name: "morango",
              value: 20,
              amount: 4
            },
          ],
          client: %Client{
            name: "romulo",
            cep: "11233234"
          }
        }

      response_body = %{
        "value" => 20
      }

      expect(Tesla.Mock, :call, fn %Tesla.Env{
        method: :get,
      } = env, _ ->
        {:ok, %Tesla.Env{env | status: 200, body: response_body}}
      end)

      assert ShipCost.calc_cart_ship(cart) ==
        {:ok, %{ship_cost: 0, total_cart: 128}}

    end
  end
end
