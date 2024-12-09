defmodule Solutions.ReadFile do
  def get!(path) do
    {:ok, contents} = File.read(path)
    contents |> String.split("\n", trim: true)
  end

  def get_two!(path) do
    {:ok, contents} = File.read(path)
    contents |> String.split("\n\n", trim: true)
  end
end
