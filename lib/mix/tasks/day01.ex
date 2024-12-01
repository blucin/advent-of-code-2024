defmodule Mix.Tasks.Day01 do
  @moduledoc "Usage: mix day01 input_file.txt"
  @shortdoc "Solve Day 1 of the Advent of Code."
  use Mix.Task
  require Logger

  def run(args) do
    {ans_part1, ans_part2} = Enum.at(args, 0)
    |> Solutions.ReadFile.get!()
    |> Solutions.Day01.solve()
    Logger.info("\n\nSolution1: #{ans_part1}\nSolution2: #{ans_part2}")
  end
end
