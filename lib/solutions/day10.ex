defmodule Solutions.Day10 do
  defp explore(q, grid, visited, ans) do
    case :queue.out(q) do
      {{:value, {vr, vc}}, q} ->
        curr_val = grid |> Enum.at(vr) |> Enum.at(vc)

        cond do
          curr_val == 9 ->
            explore(q, grid, visited, ans + 1)

          true ->
            neighbours =
              [
                {vr + 1, vc},
                {vr - 1, vc},
                {vr, vc + 1},
                {vr, vc - 1}
              ]
              |> Enum.filter(fn {nr, nc} ->
                not MapSet.member?(visited, {nr, nc}) and
                  nr >= 0 and nr < Enum.count(grid) and
                  nc >= 0 and nc < Enum.count(Enum.at(grid, 0)) and
                  grid |> Enum.at(nr) |> Enum.at(nc) == curr_val + 1
              end)

            visited =
              Enum.reduce(neighbours, visited, fn {r, c}, acc ->
                MapSet.put(acc, {r, c})
              end)

            q =
              Enum.reduce(neighbours, q, fn {r, c}, acc ->
                :queue.in({r, c}, acc)
              end)

            explore(q, grid, visited, ans)
        end

      {:empty, _} ->
        ans
    end
  end

  defp part1(grid, zr, zc) do
    q = :queue.from_list([{zr, zc}])
    visited = MapSet.new([{zr, zc}])
    explore(q, grid, visited, 0)
  end

  def solve(lines) do
    grid =
      lines
      |> Enum.map(fn line ->
        String.split(line, "", trim: true)
        |> Enum.map(&String.to_integer/1)
      end)

    zero_pos =
      for {line, row} <- Enum.with_index(grid),
          {num, col} <- Enum.with_index(line),
          reduce: [] do
        zero_pos ->
          if num == 0 do
            [{row, col} | zero_pos]
          else
            zero_pos
          end
      end

    part1 = zero_pos
    |> Enum.map(fn {zr, zc} -> part1(grid, zr, zc) end)
    |> Enum.sum()

    {part1, 0}
  end
end
