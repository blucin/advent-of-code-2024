defmodule Solutions.Day04 do
  defp is_valid_pos?(r, c, h, w) do
    r >= 0 && r < h && c >= 0 && c < w
  end

  # checks if a word is present diagonally, vertically or horizontally
  # given a position (r, c) of the first letter
  defp contains_word?(lines, r, c, dr, dc, h, w, word) do
    1..(String.length(word) - 1)
    |> Enum.reduce({true, r, c}, fn i, {acc, curr_r, curr_c} ->
      cond do
        !is_valid_pos?(curr_r, curr_c, h, w) -> {false, curr_r, curr_c}
        Enum.at(lines, curr_r) |> String.at(curr_c) != String.at(word, i) -> {false, curr_r, curr_c}
        true -> {acc, curr_r + dr, curr_c + dc}
      end
    end)
    |> elem(0)
  end

  def solve(lines) do
    {grid_len, grid_height} = {Enum.count(lines), String.length(lines |> Enum.at(0))}
    directions = [{-1, 0}, {1, 0}, {0, -1}, {0, 1}, {-1, -1}, {-1, 1}, {1, -1}, {1, 1}]

    {xmas_cnt, xmas_a_char_pos } = for {line, row} <- Enum.with_index(lines),
        {char, col} <- Enum.with_index(String.graphemes(line)),
        reduce: {0, %{}} do
        {xmas_cnt, xmas_a_char_pos} ->
          cond do
            char == "X" ->
              {Enum.reduce(directions, 0, fn {dr, dc}, acc ->
                if contains_word?(lines, row + dr, col + dc, dr, dc, grid_height, grid_len, "XMAS") do
                  acc + 1
                else
                  acc
                end
              end) + xmas_cnt, xmas_a_char_pos}
            char == "M" ->
              diagonal_dirs = [{-1, -1}, {-1, 1}, {1, -1}, {1, 1}]
              {xmas_cnt, Enum.reduce(diagonal_dirs, xmas_a_char_pos, fn {dr, dc}, xmas_a_char_pos ->
                if contains_word?(lines, row + dr, col + dc, dr, dc, grid_height, grid_len, "MAS") do
                  {a_posx, a_posy} = {col + dc, row + dr}
                  Map.update(xmas_a_char_pos, {a_posx, a_posy}, 1, &(&1 + 1))
                else
                  xmas_a_char_pos
                end
              end)}
            true ->
              {xmas_cnt, xmas_a_char_pos}
          end
    end

    overlapping_mas_cnt = xmas_a_char_pos
    |> Map.values()
    |> Enum.count(&(&1 > 1))

    {xmas_cnt, overlapping_mas_cnt}
  end
end
