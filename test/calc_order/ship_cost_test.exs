defmodule CalcOrder.ShipCostTest do
	use ExUnit.Case

  import Mox

  alias CalcOrder.ShipCost
  alias CalcOrder.Cart
  alias CalcOrder.Product

  describe "sum_cart" do
    test "sum_cart with right params" do
      carts = [
        %Cart{
          product: %Product{
            name: "banana",
            value: 10
          },
          amount: 4
        },
        %Cart{
          product: %Product{
            name: "laranja",
            value: 2
          },
          amount: 4
        },
        %Cart{
          product: %Product{
            name: "morango",
            value: 20
          },
          amount: 4
        }
      ]

      response_body = %{
        "value" => 20
      }

      expect(TeslaMock, :call, fn %Tesla.Env{
        method: :get,
      } ->
        {:ok, %Tesla.Env{env | status: 200, body: response_body}}
      end)

      assert ShipCost.sum_cart(carts) == 148
    end

    test "sum_cart with no products" do
      assert ShipCost.sum_cart(carts) == 0
    end

    test "sum_cart total lower than 100" do

    end
  end
end
