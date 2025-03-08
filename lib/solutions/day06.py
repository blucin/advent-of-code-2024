import sys
sys.setrecursionlimit(7000)

# turn right map
turn_right = {
    # up -> right
    ( 0,-1): (1,0),
    # down -> left
    ( 0, 1): (-1,0),
    # right -> down
    ( 1, 0): (0,1),
    # left -> up
    (-1, 0): (0,-1)
}

def part1(x, y, grid):
    visited = set()
    def walk(x, y, dx, dy, grid):
        visited.add((x,y))
        new_x, new_y = x + dx, y + dy
        if new_x < 0 or new_y < 0 or new_x >= len(grid[0]) or new_y >= len(grid):
            # has stepped outside
            return
        if grid[new_y][new_x] == "#": # turn right
            new_dx, new_dy = turn_right[(dx, dy)]
            return walk(x, y, new_dx, new_dy, grid)
        return walk(new_x, new_y, dx, dy, grid)
    walk(x, y, 0, -1, grid)
    return visited

def part2(x, y, ogGrid, ogVisited):

    def isWalkLoop(x, y, dx, dy, grid, visited):        
        visited.add((x,y,dx,dy))
        new_x, new_y = x + dx, y + dy
        if new_x < 0 or new_y < 0 or new_x >= len(grid[0]) or new_y >= len(grid):
            return False # has stepped outside
        if grid[new_y][new_x] == "#":
            new_dx, new_dy = turn_right[(dx, dy)] # turn right
            return isWalkLoop(x, y, new_dx, new_dy, grid, visited)
        if (new_x, new_y, dx, dy) in visited:
            return True # loop detected
        return isWalkLoop(new_x, new_y, dx, dy, grid, visited)

    # 1. 
    # walk all possible grids
    # new obstruction cannot be plaved on the start position or any of the obstructions
    
    # 2.
    # only place the new obstruction on guard's path. It's pointless to place it elsewhere
    part2 = 0
    for vx, vy in ogVisited:
        ogGrid[vy][vx] = "#"
        if isWalkLoop(x, y, 0, -1, ogGrid, set()):
            part2 += 1
        ogGrid[vy][vx] = "."
    return part2

with open("lib/inputs/day06.txt") as f:
    grid = list(map(list, f.read().strip().split("\n")))
    start_pos = (0,0)
    for i in range(len(grid)):
        for j in range(len(grid[i])):
            if grid[i][j] == "^":
                start_pos = (j,i)
                break
    visited = part1(start_pos[0], start_pos[1], grid)
    ans1 = len(visited)
    print(ans1)
    
    ans2 = part2(start_pos[0], start_pos[1], grid, visited)
    print(ans2)
