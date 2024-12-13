defmodule Mix.Tasks.Day13 do
  def run(args) do
    Enum.at(args, 0)
    |> Solutions.ReadFile.get_sections!()
    |> Solutions.Day13.solve()
    |> IO.inspect()
  end
end
