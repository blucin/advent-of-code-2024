from collections import defaultdict
import heapq

def printGrid(grid):
    for row in grid:
        print("".join(row))
    print("\n")

def printNumberedGrid(grid):
    for row in grid:
        nrow = [str(c) for c in row]
        print("\t".join(nrow))
    print("\n")
    
# def getSubGrid(grid, cr, cc, radius):
#     rows = len(grid)
#     cols = len(grid[0])
#     top = max(0, cr - radius)
#     bottom = min(rows, cr + radius + 1)
#     left = max(0, cc - radius)
#     right = min(cols, cc + radius + 1)
#     subgrid = [row[left:right] for row in grid[top:bottom]]
#     distsubgrid = [
#         [abs((top + i) - cr) + abs((left + j) - cc) for j in range(right - left)]
#         for i in range(bottom - top)
#     ]
#     return (subgrid, distsubgrid)

P1_MIN_PICOSECONDS = 100
P2_MIN_PICOSECONDS = 100
# TEST CASES
# p1: All possible picoseconds more than 2 iirc
# p2: MIN_PICOSECONDS = 50

with open("lib/inputs/day20.txt") as f:
    grid = [list(line) for line in f.read().strip().split("\n")]
    walls = [(r, c) for r, row in enumerate(grid) for c, cell in enumerate(row) if cell == '#']
    rows, cols = len(grid), len(grid[0])

    sr, sc, er, ec = 0, 0, 0, 0
    for i, row in enumerate(grid):
        for j, cell in enumerate(row):
            if cell == 'S':
                sr, sc = i, j
            if cell == 'E':
                er, ec = i, j
    
                # r c dist
    minHeap = [(sr, sc, 0)]
    dists = [[-1 for _ in range(cols)] for _ in range(rows)]
    seen = {(sr, sc)}
    while minHeap:
        r, c, d = heapq.heappop(minHeap)
        dists[r][c] = d

        for nr, nc in [(r+1, c), (r-1, c), (r, c-1), (r, c+1)]:
            if nr < 0 or nc < 0 or nr >= rows or nc >= cols: continue
            if grid[nr][nc] == "#": continue
            if (nr, nc) in seen: continue
            seen.add((nr, nc))
            heapq.heappush(minHeap, (nr, nc, d+1))

    part1 = 0
    part2 = 0
    # saved time -> count
    jumps1 = defaultdict(int)
    jumps2 = defaultdict(int)
    for r in range(rows):
        for c in range(cols):
            if grid[r][c] == "#": continue
            '''
            part1
            numbers representing the jumpable neighbours
            if we cheat within the radius of 2
              1
              #
            3#.#4
              #
              2
            '''
            p1jumpableneighboursifcheated = [
                (r+2, c), (r-2, c),
                (r, c+2), (r, c-2)
            ]
            for nr, nc in p1jumpableneighboursifcheated:
                if nr < 0 or nc < 0 or nr >= rows or nc >= cols: continue
                if grid[nr][nc] == "#": continue
                
                savedTime = dists[nr][nc] - dists[r][c] - 2
                if savedTime >= P1_MIN_PICOSECONDS:
                    jumps1[savedTime] += 1
            '''
            part2
            we will be looking for all possible jumps
            if we cheat within the radius 20
            '''
            # subgrid around the current cell, distance from the current cell to other nodes in the subgrid
            # subgrid, distsubgrid = getSubGrid(dists, r, c, 20)
            # for i, row in enumerate(subgrid):
            #     for j, n in enumerate(row):
            #         if n == -1: continue
            #         savedTime = n - dists[r][c] - distsubgrid[i][j]
            #         if savedTime >= P2_MIN_PICOSECONDS:
            #             jumps2[savedTime] += 1
            RADIUS = 20
            for dr in range(-RADIUS, RADIUS + 1):
                for dc in range(-RADIUS, RADIUS + 1):
                    if abs(dr) + abs(dc) <= RADIUS:
                        nr, nc = r + dr, c + dc
                        if nr < 0 or nc < 0 or nr >= rows or nc >= cols: continue
                        if grid[nr][nc] == "#": continue
                        manhatDist = abs(dr) + abs(dc)
                        normalDist = dists[nr][nc] - dists[r][c]
                        savedTime = normalDist - manhatDist
                        if savedTime >= P2_MIN_PICOSECONDS:
                            jumps2[savedTime] += 1

    for k, v in jumps1.items():
        part1 += v
    for k, v in jumps2.items():
        part2 += v
    print(part1)
    print(part2)