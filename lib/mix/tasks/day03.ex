defmodule Mix.Tasks.Day03 do
  require Logger

  # TODO : merge all tasks in one tasks
  def run(args) do
    {ans_part1, ans_part2} = Enum.at(args, 0)
    |> Solutions.ReadFile.get!()
    |> Solutions.Day03.solve()
    Logger.info("\n\nSolution1: #{ans_part1}\nSolution2: #{ans_part2}")
  end
end
