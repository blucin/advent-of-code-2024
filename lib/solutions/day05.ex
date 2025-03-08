defmodule Solutions.Day05 do
  defp parse_rule(rules) do
    rules
    |> String.split("\n", trim: true)
    |> Enum.map(fn rule -> String.split(rule, "|") end)
    |> Enum.reduce(%{}, fn [k, v], acc ->
      {key, val} = {String.to_integer(k), String.to_integer(v)}
      Map.update(acc, key, MapSet.new([val]), &MapSet.put(&1, val))
    end)
  end

  defp valid_update?(rule_map, update) do
    update
    |> Enum.reduce({true, 0}, fn num, {acc, idx} ->
      next_num = Enum.at(update, idx + 1)
      curr_num_afters = Map.get(rule_map, num)

      case next_num in curr_num_afters do
        false -> {false, idx}
        true -> {acc, idx + 1}
      end
    end)
    |> elem(0)
  end

  defp get_validate_updates(rule_map, updates) do
    updates
    |> String.split("\n", trim: true)
    |> Enum.map(fn update ->
      update
      |> String.split(",", trim: true)
      |> IO.inspect()
      |> Enum.map(&String.to_integer/1)
    end)
    |> IO.inspect()
  end

  def solve([rules, updates]) do
    rule_map = parse_rule(rules) |> IO.inspect()
    {valid_updates, invalid_updates} = get_validate_updates(rule_map, updates)
    IO.inspect(valid_updates)
  end
end
