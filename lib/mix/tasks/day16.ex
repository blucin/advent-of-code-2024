defmodule Mix.Tasks.Day16 do
  def run(args) do
    Enum.at(args, 0)
    |> Solutions.ReadFile.get!()
    |> Solutions.Day16.solve()
    |> IO.inspect()
  end
end
