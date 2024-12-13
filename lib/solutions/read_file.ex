defmodule Solutions.ReadFile do
  def get!(path) do
    {:ok, contents} = File.read(path)
    contents |> String.split("\n", trim: true)
  end

  # same as get_sections! but keeping it for backwards compatibility
  def get_two!(path) do
    {:ok, contents} = File.read(path)
    contents |> String.split("\n\n", trim: true)
  end

  def get_sections!(path) do
    {:ok, contents} = File.read(path)
    contents |> String.split("\n\n", trim: true)
  end
end
