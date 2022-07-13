defmodule WordsInNumbers do

  @letter_value %{
    "a" => 1,
    "b" => 2,
    "c" => 3,
    "d" => 4,
    "e" => 5,
    "f" => 6,
    "g" => 7,
    "h" => 8,
    "i" => 9,
    "j" => 10,
    "k" => 11,
    "l" => 12,
    "m" => 13,
    "n" => 14,
    "o" => 15,
    "p" => 16,
    "q" => 17,
    "r" => 18,
    "s" => 19,
    "t" => 20,
    "u" => 21,
    "v" => 22,
    "w" => 23,
    "x" => 24,
    "y" => 25,
    "z" => 26,
    "A" => 27,
    "B" => 28,
    "C" => 29,
    "D" => 30,
    "E" => 31,
    "F" => 32,
    "G" => 33,
    "H" => 34,
    "I" => 35,
    "J" => 36,
    "K" => 37,
    "L" => 38,
    "M" => 39,
    "N" => 40,
    "O" => 41,
    "P" => 42,
    "Q" => 43,
    "R" => 44,
    "S" => 45,
    "T" => 46,
    "U" => 47,
    "V" => 48,
    "W" => 49,
    "X" => 50,
    "Y" => 51,
    "Z" => 52
  }

  def get_value_letter(letter) do
    Map.get(@letter_value, letter, 0)
  end

  def get_value_word(word) do
    String.split(word, "")
    |> Enum.filter(fn e -> e != "" end)
    |> Enum.map(&(get_value_letter(&1)))
    |> Enum.sum()
  end

  def is_word_cousin(word) do
    number = get_value_word(word)
    Enum.filter(1..number, fn num -> rem(num, number) == 0 end)
    |> length() > 2
  end

  def is_word_happy(word) do
    word
    |> get_value_word()
    |> HappyNumbers.is_happy([])
  end

  def is_word_multiple_3or5(word) do
    number = get_value_word(word)
    if rem(number, 3) == 0 or rem(number, 5) == 0 do
      true
    else
      false
    end
  end
end
