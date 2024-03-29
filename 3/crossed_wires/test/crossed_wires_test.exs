defmodule CrossedWiresTest do
  use ExUnit.Case
  doctest CrossedWires

  test "closest intersections" do
    assert (hd tl CrossedWires.closest_intersection("R75,D30,R83,U83,L12,D49,R71,U7,L72\nU62,R66,U55,R34,D71,R55,D58,R83")) == 159
    assert (hd tl CrossedWires.closest_intersection("R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51\nU98,R91,D20,R16,D67,R40,U7,R15,U6,R7")) == 135
  end

  test "number of steps" do
    assert (hd tl CrossedWires.number_of_steps("R75,D30,R83,U83,L12,D49,R71,U7,L72\nU62,R66,U55,R34,D71,R55,D58,R83")) == 610
    assert (hd tl CrossedWires.number_of_steps("R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51\nU98,R91,D20,R16,D67,R40,U7,R15,U6,R7")) == 410
  end
  
end
