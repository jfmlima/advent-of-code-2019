defmodule Intcode do
  def part_1() do
    parse_input()
    |> part_1
  end

  @spec part_1(any) :: any
  def part_1(values) do
    rec(values, 0)
  end

  defp rec(values, idx) do
    op = Enum.at(values, idx)

    case op do
      99 -> values
      1 -> calc(fn x, y -> x + y end, values, idx)
      2 -> calc(fn x, y -> x * y end, values, idx)
    end
  end

  defp calc(ft, values, idx) do
    f = Enum.at(values, Enum.at(values, idx + 1))
    s = Enum.at(values, Enum.at(values, idx + 2))
    pos = Enum.at(values, idx + 3)
    rec(List.replace_at(values, pos, ft.(f, s)), idx + 4)
  end

  defp parse_input() do
    File.read!("../input.txt")
    |> String.split(",")
    |> Enum.map(&String.to_integer(&1))
  end

  def part_2_iterative() do
    input = parse_input()

    for i <- 0..99 do
      for j <- 0..99 do
        values = input
        t = List.replace_at(values, 1, i)
        nl = List.replace_at(t, 2, j)
        val = Enum.at(part_1(nl), 0)

        cond do
          val == 19690720 -> [i, j]
          :else -> 0
        end
      end
    end
  end

  def part_2_recursive() do
    input = parse_input()
    rt(0, 0, input)
  end

  defp rt(i, j, input) do
    val = Enum.at(part_1(input), 0)

    cond do
      val == 19690720 ->
        noun = Enum.at(input, 1)
        verb = Enum.at(input, 2)
        %{noun: noun, verb: verb, result: 100 * noun + verb}

      true ->
        if i < 99 do
          if j >= 99 do
            rt(i + 1, 0, List.replace_at(input, 1, i))
          else
            rt(i, j + 1, List.replace_at(input, 2, j))
          end
        end
    end
  end
end
