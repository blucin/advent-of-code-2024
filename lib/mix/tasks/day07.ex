defmodule Mix.Tasks.Day07 do
  def run(args) do
    Enum.at(args, 0)
    |> Solutions.ReadFile.get!()
    |> Solutions.Day07.solve()
    |> IO.inspect()
  end
end
