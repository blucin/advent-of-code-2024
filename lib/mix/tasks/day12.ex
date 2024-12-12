defmodule Mix.Tasks.Day12 do
  def run(args) do
    Enum.at(args, 0)
    |> Solutions.ReadFile.get!()
    |> Solutions.Day12.solve()
    |> IO.inspect()
  end
end
