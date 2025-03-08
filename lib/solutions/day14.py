import re

def part1(bots, rows, cols):
    for i in range(1, 101):
        new_bots = []
        for bot in bots:
            c, r, vc, vr = bot
            new_bots.append([(c+vc) % cols, (r+vr) % rows, vc, vr])
        bots = new_bots
    grid = [["." for _ in range(cols)] for _ in range(rows)]
    for bot in bots:
        c, r, _, _ = bot
        if grid[r % rows][c % cols] == ".":
            grid[r % rows][c % cols] = "1"
        else:
            num = int(grid[r % rows][c % cols])
            grid[r % rows][c % cols] = str(num + 1)
    
    quad1, quad2, quad3, quad4 = 0, 0, 0, 0
    half1, half2 = grid[0:rows//2], grid[rows//2+1:]
    pass
    for i, row in enumerate(half1):
        for j, char in enumerate(row):
            if j < cols//2 and char != ".":
                quad1 += int(char)
            if j > cols//2 and char != ".":
                quad2 += int(char)

    for i, row in enumerate(half2):
        for j, char in enumerate(row):
            if j < cols//2 and char != ".":
                quad3 += int(char)
            if j > cols//2 and char != ".":
                quad4 += int(char)

    return quad1 * quad2 * quad3 * quad4

def part2(bots, rows, cols):
    for i in range(1, 9000):
        print("i", i)
        new_bots = []
        for bot in bots:
            c, r, vc, vr = bot
            new_bots.append([(c+vc) % cols, (r+vr) % rows, vc, vr])
        bots = new_bots
        
        grid = [["." for _ in range(cols)] for _ in range(rows)]
        for bot in bots:
            c, r, _, _ = bot
            grid[r % rows][c % cols] = "#"
        for row in grid:
            print("".join(row))
        print("\n\n\n")

# with open("/home/blucin/Prog/advent_of_code_2024/lib/inputs/day14_test.txt") as f:
with open("lib/inputs/day14.txt") as f:
    bots = [list(map(int, re.findall(r"-?\d+", bot))) for bot in [l for l in f.read().strip().split("\n")]]
    rows = 103
    cols = 101
    
    print(part1(bots, rows, cols))
    part2(bots, rows, cols)

