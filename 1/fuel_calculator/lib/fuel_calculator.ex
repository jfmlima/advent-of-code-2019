defmodule FuelCalculator do

  def part_1() do
    parse_input()
    |> Enum.map(&calculate(&1))
    |> Enum.sum()
  end

  def calculate(mass) do
    Float.floor(mass / 3 - 2)
  end

  def part_2() do
    parse_input()
    |> Enum.map(&calculateFuelOfFuel(&1))
    |> Enum.sum()
  end

  def calculateFuelOfFuel(mass) do
    nf = calculate(mass)

    cond do
      nf < 0 -> 0
      :else  -> nf + calculateFuelOfFuel(nf)
    end
  end

  defp parse_input() do
    {:ok, file} = File.read("../input.txt")

    file
    |> String.split("\n")
    |> Enum.map(&String.to_integer(&1))
  end
end
