defmodule PasswordMatcher do
  def part_1() do
    count_matches("367479", 0)
  end

  defp count_matches("893698", c) do c end

  defp count_matches(b, c) do
    i = Integer.to_string(String.to_integer(b) + 1)

    if(matches(b, 0)) do count_matches(i, c + 1) else count_matches(i, c) end
  end

  defp matches(_, -1) do false end

  defp matches(<<f::binary-size(1)>> <> <<s::binary-size(1)>> <> "", c) do (f < s && c > 4) || (f == s && c > 3) end

  defp matches(<<f::binary-size(1)>> <> <<f::binary-size(1)>> <> t, c) do matches(f <> t, c + 2) end

  defp matches(<<f::binary-size(1)>> <> <<s::binary-size(1)>> <> t, c) do if f < s do matches(s<>t, c + 1) else matches("", -1) end end

  def part_2() do
    367479..893698
    |> Enum.filter(&is_sequential(Integer.to_string(&1)))
    |> Enum.map(&Integer.digits(&1))
    |> Enum.map(fn digits -> Enum.reduce(digits, %{}, fn x, acc -> Map.update(acc, x, 1, &(&1 + 1)) end ) end)
    |> Enum.filter(&(Enum.member?(Map.values(&1), 2)))
    |> Enum.count
  end

  defp is_sequential(<<f::binary-size(1)>> <> <<s::binary-size(1)>>) do
    f < s || f == s
  end

  defp is_sequential(<<f::binary-size(1)>> <> <<s::binary-size(1)>> <> t) do
    if(f < s || f == s) do is_sequential(s <> t) else false end
  end
end
