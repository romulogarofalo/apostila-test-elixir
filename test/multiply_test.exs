defmodule MultiplyTest do
  use ExUnit.Case

  describe "multiply3or5" do
    test "3 or 5" do
      result = Multiply.get_multiplier(1..9, 3) ++ Multiply.get_multiplier(1..9, 5)
      assert result == [3, 6, 9, 5]
      assert Enum.sum(result) == 23
    end

    test "with 3 or 5" do
      assert Multiply.multiplier3or5() == 267333
    end

    test "with 3 and 5" do
      assert Multiply.multiplier3and5() == 33165
    end

    test "with 3 or 5 and 7" do
      assert Multiply.multiplier3or5and7() == 37898
    end
  end
end
