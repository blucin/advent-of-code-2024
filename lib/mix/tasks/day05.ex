defmodule Mix.Tasks.Day05 do
  def run(args) do
    Enum.at(args, 0)
    |> Solutions.ReadFile.get_two!()
    |> Solutions.Day05.solve()
    |> IO.inspect()
  end
end
