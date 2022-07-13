defmodule Multiply do
  def get_multiplier(limit, multi) do
    Enum.filter(limit, fn elem ->
      if rem(elem, multi) == 0 do
        true
      else
        false
      end
    end)
end

def multiplier3or5 do
  multiples = get_multiplier(1..1000, 3) ++ get_multiplier(1..1000, 5)
  Enum.sum(multiples)
end

def multiplier3and5 do
  get_multiplier(1..1000, 3)
  |> get_multiplier(5)
  |> Enum.sum()
end

def multiplier3or5and7 do
  get_multiplier(1..1000, 3) ++ get_multiplier(1..1000, 5)
  |> get_multiplier(7)
  |> Enum.sum()
end
end
