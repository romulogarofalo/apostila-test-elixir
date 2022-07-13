defmodule WordsInNumbersTest do
	use ExUnit.Case

  describe "get_value_letter/1" do
    test "valid input" do
      assert WordsInNumbers.get_value_letter("B") == 28
    end

    test "invalid input" do
      assert WordsInNumbers.get_value_letter("123") == 0
    end
  end

  describe "get_value_word/1" do
    test "word with 45 of value" do
      assert WordsInNumbers.get_value_word("batata") == 45
    end

    test "word with 45 of value and with invalid caractere in the middle" do
      assert WordsInNumbers.get_value_word("bat$ata") == 45
    end
  end

  describe "is_word_happy/1" do
    test "with a happy word" do
      assert WordsInNumbers.is_word_happy("g")
    end

    test "with not happy word" do
      assert not WordsInNumbers.is_word_happy("h")
    end
  end

  describe "is_word_multiple_3or5/1" do
    test "when is multiple" do
      assert WordsInNumbers.is_word_multiple_3or5("i")
    end

    test "when is not multiple" do
      assert not WordsInNumbers.is_word_multiple_3or5("k")
    end
  end

end
