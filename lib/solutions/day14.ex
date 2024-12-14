defmodule Solutions.Day14 do
  defp init_grid(rows, cols) do
    Enum.map(1..rows, fn _ ->
      Enum.map(1..cols, fn _ -> 0 end)
    end)
  end

  defp split_quadrants(grid, rows, cols) do
    row_mid = div(rows, 2)
    col_mid = div(cols, 2)

    [
      Enum.slice(grid, 0, row_mid) |> Enum.map(&Enum.slice(&1, 0, col_mid)),
      Enum.slice(grid, 0, row_mid) |> Enum.map(&Enum.slice(&1, col_mid + 1, cols)),
      Enum.slice(grid, row_mid + 1, rows) |> Enum.map(&Enum.slice(&1, 0, col_mid)),
      Enum.slice(grid, row_mid + 1, rows) |> Enum.map(&Enum.slice(&1, col_mid + 1, cols))
    ]
  end

  defp get_bot_config(init_bot_config, iter_cnt, rows, cols) do
    Enum.reduce(1..iter_cnt, init_bot_config, fn _, acc_bots ->
      for [c, r, vc, vr] <- acc_bots do
        new_c = rem(c + vc, cols)
        new_r = rem(r + vr, rows)
        [new_c, new_r, vc, vr]
      end
    end)
  end

  def solve(lines) do
    bots =
      lines
      |> Enum.map(fn line ->
        # [c, r, vc, vr]
        line
        |> then(fn x -> Regex.scan(~r/-?\d+/, x) end)
        |> List.flatten()
        |> Enum.map(&String.to_integer/1)
      end)

    # test case rows: 7 cols: 11
    rows = 103
    cols = 101

    grid_100 =
      get_bot_config(bots, 100, rows, cols)
      |> Enum.reduce(init_grid(rows, cols), fn [c, r, _, _], acc_grid ->
        replace = (Enum.at(acc_grid, r) |> Enum.at(c)) + 1
        List.replace_at(acc_grid, r, List.replace_at(Enum.at(acc_grid, r), c, replace))
      end)

    part1 =
      grid_100
      |> split_quadrants(rows, cols)
      |> Enum.reduce(1, fn quad, acc ->
        quad_sum =
          quad
          |> Enum.map(&Enum.sum(&1))
          |> Enum.sum()

        acc * quad_sum
      end)

    # Part2
    # 6-7 min runtime solution. Requires manual inspection of the grid
    #
    # $ mix day14 lib/input/day14.txt > day14.txt
    #
    # Try to replace init_grid with "." to make it easier to find the xmas tree
    # ticks = 10000
    # for i <- 1..ticks do
    #   IO.inspect("Tick: #{i}")
    #   grid_i =
    #     get_bot_config(bots, i, rows, cols)
    #     |> Enum.reduce(init_grid(rows, cols), fn [c, r, _, _], acc_grid ->
    #       List.replace_at(acc_grid, r, List.replace_at(Enum.at(acc_grid, r), c, "#"))
    #     end)
    #     |> Enum.map(fn row ->
    #       Enum.join(row, "") |> IO.inspect()
    #     end)
    #   IO.inspect("\n\n")
    # end

    {part1, "Read the code comment for part2 solution"}
  end
end
