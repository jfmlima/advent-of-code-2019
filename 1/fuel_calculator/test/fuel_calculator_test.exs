defmodule FuelCalculatorTest do
  use ExUnit.Case
  doctest FuelCalculator

  test "GIVEN a mass WHEN calculating the needed fuel THEN returns the proper fuel value" do
    assert FuelCalculator.calculate(12) == 2
    assert FuelCalculator.calculate(14) == 2
    assert FuelCalculator.calculate(1969) == 654
    assert FuelCalculator.calculate(100756) == 33583
  end

  test "GIVEN a mass WHEN calculating the needed fuel fuel THEN returns the proper fuel value" do
    assert FuelCalculator.calculateFuelOfFuel(14) == 2
    assert FuelCalculator.calculateFuelOfFuel(1969) == 966
    assert FuelCalculator.calculateFuelOfFuel(100756) == 50346
  end
end
