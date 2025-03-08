from collections import deque

def bfs(rows, cols, fallen_bytes, limit):
    memory = [["." for _ in range(cols + 1)] for _ in range(rows + 1)]
    for col, row in fallen_bytes[:limit]:
        memory[row][col] = "#"
        
    queue = deque([(0, 0, 0)])
    seen = {(0, 0)}

    while queue:
        r, c, dist = queue.popleft()            
        if r == rows and c == cols:
            return (True, dist)
        for nr, nc in [(r + 1, c), (r - 1, c), (r, c + 1), (r, c - 1)]:
            if nr < 0 or nr > rows or nc < 0 or nc > cols or memory[nr][nc] == "#":
                continue
            if (nr, nc) in seen:
                continue        
            seen.add((nr, nc))
            queue.append((nr, nc, dist + 1))

    return (False, 0)

with open("lib/inputs/day18.txt") as f:
    # rows, cols = 6, 6
    # limit = 12
    rows, cols = 70, 70
    limit = 1024
    fallen_bytes = [list(map(int, cord.split(","))) for cord in f.read().strip().split("\n")]
        
    part1 = bfs(rows, cols, fallen_bytes, limit)
    print(part1)

    part2 = (0,0)
    for i in range(limit, len(fallen_bytes)):
        if not bfs(rows, cols, fallen_bytes, i)[0]:
            part2 = fallen_bytes[i-1]
            break
    print(part2)

