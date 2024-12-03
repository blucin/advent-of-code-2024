defmodule Solutions.Day03 do
  defp part1(lines) do
    lines
    |> Enum.reduce(0, fn line, acc ->
      Regex.scan(~r/mul\(\d+,\d+\)/, line)
      |> List.flatten()
      |> Enum.reduce(acc, fn match, inner_acc ->
        [num1, num2] =
          Regex.scan(~r/\d+/, match)
          |> List.flatten()
          |> Enum.map(&String.to_integer/1)

        inner_acc + num1 * num2
      end)
    end)
  end

  defp part2(lines) do
    lines
    |> Enum.reduce({true, 0}, fn line, {mul_enabled, acc} ->
      Regex.scan(~r/mul\(\d+,\d+\)|don't\(\)|do\(\)/, line)
      |> List.flatten()
      |> Enum.reduce({mul_enabled, acc}, fn match, {mul_enabled, acc} ->
        cond do
          match == "don't()" ->
            {false, acc}

          match == "do()" ->
            {true, acc}

          mul_enabled ->
            [num1, num2] =
              Regex.scan(~r/\d+/, match)
              |> List.flatten()
              |> Enum.map(&String.to_integer/1)

            {mul_enabled, acc + num1 * num2}

          true ->
            {mul_enabled, acc}
        end
      end)
    end)
    |> elem(1)
  end

  def solve(lines) do
    {part1(lines), part2(lines)}
  end
end
