defmodule HappyNumbersTest do
	use ExUnit.Case
	alias HappyNumbers


  describe "is_happy/2" do
    test "with 7 that is true" do
      assert HappyNumbers.is_happy(7, []) == true
    end

    test "with 8 that is false" do
      assert HappyNumbers.is_happy(8, []) == false
    end
  end
end
