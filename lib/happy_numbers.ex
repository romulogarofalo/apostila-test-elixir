defmodule HappyNumbers do

  def is_happy(1, _), do: true

  def is_happy(number, past_numbers) do
    find_in_past(number, past_numbers)
    |> case do
      false ->
        new_square = calculate_square(number)
        is_happy(new_square, [new_square] ++ past_numbers)
      _ -> false
    end
  end

  def find_in_past(number, list) do
    Enum.filter(list, fn elem ->
      elem == number
    end)
    |> length() >= 2
  end

  def calculate_square(number) do
    number
    |> Integer.to_string()
    |> String.split("")
    |> Enum.filter(fn e -> e != "" end)
    |> Enum.map(fn number ->
      String.to_integer(number) * String.to_integer(number)
    end)
    |> Enum.sum()
  end
end
