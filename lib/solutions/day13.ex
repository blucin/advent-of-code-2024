defmodule Solutions.Day13 do
  # let acnt = p, bcnt = q

  # p * ax + q * bx = px
  # p * ay + q * by = py

  # p * ax * by + q * bx * by = px * by
  # p * ay * bx + q * by * bx = py * bx
  # -            -              -
  # -------------------------------------
  # p.ax.by - p.ay.bx = px.by - py.bx
  # p ( ax.by - ay.bx ) = ( px.by - py.bx )

  # p = (px.by - py.bx)  = acnt
  #     ---------------
  #     (ax.by - ay.bx)

  # q = (px - p.ax) = (py - p.ay)  = bcnt
  #     -----------   -----------
  #     bx             by


  # 3 * acnt + 1 * bcnt
  defp get_btn_presses(ax, ay, bx, by, px, py) do
    p = (px * by - py * bx) / (ax * by - ay * bx)
    q = (px - p * ax) / bx

    # WARNING: Not a failsafe way to check for fractional parts of a float
    # read: https://elixirforum.com/t/how-can-i-get-the-fractional-part-of-a-float-only/29979/22
    if (p - trunc(p)) * 1_000_000 == 0 and (q - trunc(q)) * 1_000_000 == 0 do
      3 * trunc(p) + trunc(q)
    else
      0
    end
  end

  def solve(games) do
    {part1, part2} =
      games
      |> Enum.reduce({0, 0}, fn game, {acc1, acc2} ->
        [ax, ay, bx, by, px, py] =
          game
          |> then(fn x -> Regex.scan(~r/\d+/, x) end)
          |> List.flatten()
          |> Enum.map(&String.to_integer/1)

        {
          acc1 + get_btn_presses(ax, ay, bx, by, px, py),
          acc2 + get_btn_presses(ax, ay, bx, by, px + 10000000000000, py + 10000000000000)
        }
      end)

    {part1, part2}
  end
end
