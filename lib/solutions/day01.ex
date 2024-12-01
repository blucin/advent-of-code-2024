defmodule Solutions.Day01 do
  @moduledoc "The solution to the first day of the Advent of Code."

  defp part1(id_list_l, id_list_r) do
    sorted_l = Enum.sort(id_list_l)
    sorted_r = Enum.sort(id_list_r)
    Enum.zip(sorted_l, sorted_r)
      |> Enum.reduce(0, fn {id_l, id_r}, acc ->
        acc + abs(id_l - id_r)
      end)
  end

  defp part2(id_list_l, id_list_r) do
  r_freq_map = Enum.frequencies(id_list_r)
  id_list_l |>
    Enum.reduce(0, fn id_l, acc ->
      if r_freq_map[id_l] == nil do
        acc
      else
        acc + (id_l * r_freq_map[id_l])
      end
    end)
  end

  def solve(lines) do
    # parse left and right list
    [id_list_l, id_list_r] =
      lines
      |> Enum.map(fn line ->
        String.split(line, "   ")
        |> List.to_tuple()
      end)
      |> Enum.unzip()
      |> Tuple.to_list()
      |> Enum.map(fn id_list ->
        Enum.map(id_list, fn id ->
          {id_int, _} = Integer.parse(id)
          id_int
        end)
      end)

    ans_part_1 = part1(id_list_l, id_list_r)
    ans_part_2 = part2(id_list_l, id_list_r)
    {ans_part_1, ans_part_2}
  end
end
