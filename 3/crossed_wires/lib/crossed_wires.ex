defmodule CrossedWires do
  def part_1() do
    parse_input()
      |> closest_intersection()
  end

  def closest_intersection(wires) do
    paths = wires
    |> String.split("\n")
    |> Enum.map(&generate_path/1)

    # maybe refactoring to MapSet?
    hd(paths)
    |> Enum.filter(fn x -> Enum.member?(hd(tl(paths)), x) end)
    |> tl
    |> Enum.map(&get_distance(&1))
    |> Enum.min_by(fn x -> tl(x) end)
  end

  defp parse_input() do
    File.read!("../input.txt")
  end

  defp generate_path(wire) do
    wire |> String.split(",") |> Enum.reduce([{0, 0}], fn elem, acc -> walk(elem, acc) end)
  end

  defp walk(cmd, current_path) do
    move = get_next_step(List.last(current_path), cmd)
    current_path ++ move
  end

  defp get_next_step({x, y}, <<dir, count::binary>>) do
    dir = hd(String.graphemes(<<dir>>))
    count = String.to_integer(count)

    case dir do
      "R" -> 1..count |> Enum.map(fn c -> {x + c, y} end)
      "L" -> 1..count |> Enum.map(fn c -> {x - c, y} end)
      "U" -> 1..count |> Enum.map(fn c -> {x, y + c} end)
      "D" -> 1..count |> Enum.map(fn c -> {x, y - c} end)
    end
  end

  defp get_distance(pos) do
    [pos, abs(elem(pos, 0)) + abs(elem(pos, 1))]
  end
end
