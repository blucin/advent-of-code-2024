# Warning: Fails for very specific cases in part2
# Below is the solution for day02 in python that I wrote before
defmodule Solutions.Day02 do
  defp valid_report_cnt(reports, tolerance) do
    Enum.reduce(reports, 0, fn report, acc ->
      is_valid =
        Enum.reduce_while(
          report,
          {true, nil, nil, tolerance},
          fn curr, {is_valid, prev, prevStatus, tol} ->
            if prev == nil do
              {:cont, {is_valid, curr, nil, tol}}
            else
              diff = abs(curr - prev)
              status = cond do
                curr > prev -> :increasing
                curr < prev -> :decreasing
                true -> :same
              end

              cond do
                # check acceptable difference or increasing-decreasing condition
                diff > 3 or diff < 1 or (prevStatus != nil and prevStatus != status) ->
                  if tol == 0 do
                    {:halt, {false, curr, status, tol}}
                  else
                    {:cont, {is_valid, curr, status, tol - 1}}
                  end

                true ->
                  {:cont, {is_valid, curr, status, tol}}
              end
            end
          end
        )
        |> elem(0)

      if is_valid do acc + 1 else acc end
    end)
  end

  def solve(lines) do
    parsed_reports =
      lines
      |> Enum.map(fn line ->
        String.split(line)
        |> Enum.map(&String.to_integer/1)
      end)

    {valid_report_cnt(parsed_reports, 0), valid_report_cnt(parsed_reports, 1)}
  end
end

# def checkDiff(a, b):
#     diff = abs(a-b)
#     if diff > 3 or diff < 1:
#         return False
#     return True

# def checkReportP1(report, i, isWhat):
#     if i == len(report):
#         return True
#     if 0 < i < len(report):
#         curr = report[i]
#         prev = report[i - 1]
#         diff = abs(curr - prev)
#         if diff > 3 or diff < 1:
#             return False
#         if curr == prev:
#             return False
#         if curr > prev:
#             if isWhat and isWhat != "increasing":
#                 return False
#             isWhat = "increasing"
#         if curr < prev:
#             if isWhat and isWhat != "decreasing":
#                 return False
#             isWhat = "decreasing"
#     return checkReportP1(report, i+1, isWhat)

# def checkReportP2(report, i, isWhat, tolerance):
#     if i == len(report):
#         return True
#     if i > 0 and i < len(report):
#         curr = report[i]
#         prev = report[i - 1]
#         diff = abs(curr - prev)
#         if diff > 3 or diff < 1:
#             if tolerance == 0:
#                 return checkReportP2(report, i+1, isWhat, tolerance+1)
#             return False
#         if curr == prev:
#             if tolerance == 0:
#                 return checkReportP2(report, i+1, isWhat, tolerance+1)
#             return False
#         if curr > prev:
#             if isWhat and isWhat != "increasing":
#                 if tolerance == 0:
#                     return checkReportP2(report, i+1, isWhat, tolerance+1)
#                 return False
#             isWhat = "increasing"
#         if curr < prev:
#             if isWhat and isWhat != "decreasing":
#                 if tolerance == 0:
#                     return checkReportP2(report, i+1, isWhat, tolerance+1)
#                 return False
#             isWhat = "decreasing"
#     return checkReportP2(report, i+1, isWhat, tolerance)

# with open("../inputs/day02_p.txt") as file:
#     safeCntP1 = 0
#     safeCntP2 = 0
#     for line in file.read().split("\n"):
#         report = list(map(int, line.split(" ")))
#         if checkReportP1(report, 0, None):
#             safeCntP1 += 1
#         if checkReportP2(report, 0, None, 0):
#             print(report)
#             safeCntP2 += 1
#     print("Part1 Sol:", safeCntP1)
#     print("Part2 Sol:", safeCntP2)
