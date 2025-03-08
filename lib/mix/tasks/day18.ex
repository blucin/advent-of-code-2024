defmodule Mix.Tasks.Day18 do
  def run(args) do
    Enum.at(args, 0)
    |> Solutions.ReadFile.get!()
    |> Solutions.Day18.solve()
    |> IO.inspect()
  end
end
