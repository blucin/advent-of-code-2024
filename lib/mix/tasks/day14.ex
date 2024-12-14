defmodule Mix.Tasks.Day14 do
  def run(args) do
    Enum.at(args, 0)
    |> Solutions.ReadFile.get!()
    |> Solutions.Day14.solve()
    |> IO.inspect()
  end
end
