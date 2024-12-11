defmodule Mix.Tasks.Day10 do
  def run(args) do
    Enum.at(args, 0)
    |> Solutions.ReadFile.get!()
    |> Solutions.Day10.solve()
    |> IO.inspect()
  end
end
