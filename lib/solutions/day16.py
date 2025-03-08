import heapq

def printGrid(grid):
    for row in grid:
        print("".join(row))
    print("\n")

with open("lib/inputs/day16.txt") as f:
    grid = [list(row) for row in f.read().strip().split("\n")]
    sr, sc = 0, 0
    for i, row in enumerate(grid):
        for j, _ in enumerate(row):
            if grid[i][j] == "S":
                sr, sc = i, j
                break

    clockwise = {
        (0, 1): (1, 0),
        (1, 0): (0, -1),
        (0, -1): (-1, 0),
        (-1, 0): (0, 1)
    }
    
    anticlockwise = {
        (0, 1): (-1, 0),
        (-1, 0): (0, -1),
        (0, -1): (1, 0),
        (1, 0): (0, 1)
    }

              # cost sr sc dr dc
              # Horse faces right initially (EAST)
    minHeap = [(0, sr, sc, 0, 1)]
    seen = {(sr, sc, 0, 1)}
    part1 = 0
    while minHeap:
        cost, r, c, dr, dc = heapq.heappop(minHeap)
        seen.add((r, c, dr, dc))

        if grid[r][c] == "E":
            part1 = cost
            break
        
        newCost = 0
        for ndr, ndc in [(0, 1), (0, -1), (1, 0), (-1, 0)]:
            if grid[r+ndr][c+ndc] == "#":
                continue
            if (r+ndr, c+ndc, ndr, ndc) in seen:
                continue
            if (ndr, ndc) == clockwise[(dr, dc)] or (ndr, ndc) == anticlockwise[(dr, dc)]:
                newCost = cost + 1001
            else:
                newCost = cost + 1
            heapq.heappush(minHeap, (newCost, r+ndr, c+ndc, ndr, ndc))
    
    print(part1)

