defmodule Solutions.Day12 do
  defp is_border!(r, c, target_char, grid) do
    len = length(grid)
    wid = length(hd(grid))
    r < 0 or r >= len or c < 0 or c >= wid or Enum.at(Enum.at(grid, r), c) != target_char
  end

  defp dfs(grid, r, c, seen, area, perimeter, sides) do
    seen = MapSet.put(seen, {r, c})
    curr_char = Enum.at(Enum.at(grid, r), c)

    valid_xy_dirs =
      [
        {1, 0},
        {-1, 0},
        {0, 1},
        {0, -1}
      ]
      |> Enum.filter(fn {dr, dc} ->
        not is_border!(r + dr, c + dc, curr_char, grid)
      end)

    corners = [
      {1, 1},
      {1, -1},
      {-1, 1},
      {-1, -1}
    ] |> Enum.filter(fn {dr, dc} ->
      not is_border!(r + dr, c + dc, curr_char, grid)
    end)

    sides = case length(corners) do
      1 -> sides + 1
      2 -> sides + 2
      3 -> sides + 1
      _ -> sides
    end
    perimeter = perimeter + (4 - length(valid_xy_dirs))
    area = area + 1

    Enum.reduce(valid_xy_dirs, {area, perimeter, sides, seen}, fn {dr, dc},
                                                        {acc_area, acc_perimeter, acc_sides, acc_seen} ->
      if MapSet.member?(acc_seen, {r + dr, c + dc}) do
        {acc_area, acc_perimeter, acc_sides, acc_seen}
      else
        {new_area, new_perimeter, new_sides, new_seen} =
          dfs(grid, r + dr, c + dc, acc_seen, acc_area, acc_perimeter, acc_sides)

        {new_area, new_perimeter, new_sides, new_seen}
      end
    end)
  end

  def solve(lines) do
    grid = Enum.map(lines, &String.split(&1, "", trim: true))

    {part1, part2, _} =
      for {line, ri} <- Enum.with_index(grid),
          {_, ci} <- Enum.with_index(line),
          reduce: {0, 0, MapSet.new()} do {acc1, acc2, seen} ->
        if MapSet.member?(seen, {ri, ci}) do
          {acc1, acc2, seen}
        else
          {area, perimeter, sides, seen} = dfs(grid, ri, ci, seen, 0, 0, 0)
          IO.inspect({grid |> Enum.at(ri) |> Enum.at(ci), area, sides})
          {acc1 + area * perimeter, acc2 + area * sides, seen}
        end
      end

    {part1, part2}
  end
end
