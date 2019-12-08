defmodule PasswordMatcher do

  def part_1() do
    IO.inspect(count_matches("367479", 0))
  end

  defp count_matches("893698", c) do c end

  defp count_matches(b, c) do
    i = Integer.to_string(String.to_integer(b) + 1)
    if(matches(b, 0)) do
      count_matches(i, c + 1)
    else count_matches(i, c) end
  end

  defp matches(_, -1) do false end

  defp matches(<<f :: binary-size(1)>> <> <<s :: binary-size(1)>> <> "", c) do
    (f < s && c > 4) || (f == s && c > 3)
  end

  defp matches(<<f :: binary-size(1)>> <> <<s :: binary-size(1)>> <> t, c) do
    n = s<>t
    cond do
      f < s -> matches(n, c+1)
      f == s -> matches(n, c+2)
      true -> matches(n, -1)
    end
  end
end
