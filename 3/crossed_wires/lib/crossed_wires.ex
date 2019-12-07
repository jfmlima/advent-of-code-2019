defmodule CrossedWires do
  def part_1() do
    parse_input()
    |> closest_distance()
  end

  def part_2() do
    parse_input()
    |> number_of_steps()

  end

  def number_of_steps(wires) do
    [p1, p2] =
      wires
      |> String.split("\n")
      |> Enum.map(&generate_path/1)

    closest_intersections(wires)
    |> Enum.map(fn i -> Enum.find_index(p1, &(i == &1)) + Enum.find_index(p2, &(i == &1)) end)
    |> Enum.min()
    |> IO.inspect
  end

  def closest_distance(wires) do
    wires
    |> closest_intersections()
    |> Enum.map(&get_distance(&1))
    |> Enum.min_by(fn x -> tl(x) end)
    |> IO.inspect
  end

  def closest_intersections(wires) do
      wires
      |> String.split("\n")
      |> Enum.map(&generate_path/1)
      |> Enum.map(&MapSet.new(tl &1))
      |> intersect
  end

  defp parse_input() do
    File.read!("../input.txt")
  end

  defp intersect([x | [y | _]]) do
    MapSet.intersection(x, y)
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
