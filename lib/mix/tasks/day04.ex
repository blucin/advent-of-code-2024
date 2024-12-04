defmodule Mix.Tasks.Day04 do
  require Logger

  def run(args) do
    Enum.at(args, 0)
    |> Solutions.ReadFile.get!()
    |> Solutions.Day04.solve()
    |> IO.inspect()
  end
end
