defmodule Solutions.ReadFile do
  def get!(path) do
    {:ok, contents} = File.read(path)
    contents |> String.split("\n", trim: true)
  end
end
