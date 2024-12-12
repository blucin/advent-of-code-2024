defmodule Solutions.Day12 do
  defp is_border!(r, c, target_char, grid) do
    len = length(grid)
    wid = length(hd(grid))
    r < 0 or r >= len or c < 0 or c >= wid or Enum.at(Enum.at(grid, r), c) != target_char
  end

  defp dfs(grid, r, c, seen, area, perimeter) do
    seen = MapSet.put(seen, {r, c})

    valid_dirs =
      [
        {1, 0},
        {-1, 0},
        {0, 1},
        {0, -1}
      ]
      |> Enum.filter(fn {dr, dc} ->
        not is_border!(r + dr, c + dc, Enum.at(Enum.at(grid, r), c), grid)
      end)

    perimeter = perimeter + (4 - length(valid_dirs))
    area = area + 1

    Enum.reduce(valid_dirs, {area, perimeter, seen}, fn {dr, dc},
                                                        {acc_area, acc_perimeter, acc_seen} ->
      if MapSet.member?(acc_seen, {r + dr, c + dc}) do
        {acc_area, acc_perimeter, acc_seen}
      else
        {new_area, new_perimeter, new_seen} =
          dfs(grid, r + dr, c + dc, acc_seen, acc_area, acc_perimeter)

        {new_area, new_perimeter, new_seen}
      end
    end)
  end

  def solve(lines) do
    grid = Enum.map(lines, &String.split(&1, "", trim: true))

    {part1, _} =
      for {line, ri} <- Enum.with_index(grid),
          {_, ci} <- Enum.with_index(line),
          reduce: {0, MapSet.new()} do {acc, seen} ->
        if MapSet.member?(seen, {ri, ci}) do
          {acc, seen}
        else
          {area, perimeter, new_seen} = dfs(grid, ri, ci, seen, 0, 0)
          {acc + area * perimeter, new_seen}
        end
      end

    {part1, 0}
  end
end
