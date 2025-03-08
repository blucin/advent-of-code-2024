defmodule Solutions.Day18 do
  defp init_grid(rows, cols, fallen_bytes) do
    Enum.map(0..rows, fn r ->
      Enum.map(0..cols, fn c ->
        if MapSet.member?(fallen_bytes, {r, c}) do
          "#"
        else
          "."
        end
      end)
    end)
  end

  defp is_valid_block!(grid, r, c) do
    len = length(grid)
    wid = length(hd(grid))
    r < 0 or r >= len or c < 0 or c >= wid or grid |> Enum.at(r) |> Enum.at(c) != "#"
  end

  defp dfs(grid, r, c, seen, fallen_bytes, end_r, end_c, dist) do
    if r == end_r && c == end_c do
      dist
    else
      seen = MapSet.put(seen, {r, c})

      valid_dirs =
        [
          {1, 0},
          {-1, 0},
          {0, 1},
          {0, -1}
        ]
        |> Enum.filter(fn {dr, dc} ->
          is_valid_block!(grid, r + dr, c + dc) &&
          not MapSet.member?(seen, {r + dr, c + dc})
        end)

      valid_dirs
      |> Enum.map(fn {dr, dc} ->
        dfs(grid, r + dr, c + dc, seen, fallen_bytes, end_r, end_c, dist + 1)
      end)
    end
  end

  def solve(lines) do
    # for test case: {rows, cols} = {6, 6}
    {rows, cols} = {6, 6}

    fallen_bytes =
      lines
      |> Enum.reduce_while(MapSet.new(), fn coord, blocks ->
        if MapSet.size(blocks) == 12 do
          {:halt, blocks}
        else
          [col, row] =
            coord
            |> String.split(",")
            |> Enum.map(&String.to_integer(&1))

          {:cont, MapSet.put(blocks, {row, col})}
        end
      end)
      |> IO.inspect()

    memory = init_grid(rows, cols, fallen_bytes)

    part1 =
      dfs(memory, 0, 0, MapSet.new(), fallen_bytes, rows, cols, 0)
      |> IO.inspect()

    {0, 0}
  end
end
