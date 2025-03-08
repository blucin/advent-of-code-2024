from sys import setrecursionlimit
setrecursionlimit(10**6)

def solve_expr(left, right, operation):
    result = None
    match operation:
        case 'AND':
            result = left & right
        case 'OR':
            result = left | right
        case 'XOR':
            result = left ^ right
    return result

def solve(exprs, wires, index):
    if index == len(exprs):
        return wires
    l, operator, r, _, target = exprs[index]
    if l not in wires:
        idx = 0
        for i, exp in enumerate(exprs):
            if exp[-1] == l:
                idx = i
                break
        wires = solve(exprs, wires, idx)
    if r not in wires:
        idx = 0
        for i, exp in enumerate(exprs):
            if exp[-1] == r:
                idx = i
                break
        wires = solve(exprs, wires, idx)
    left, right = wires[l], wires[r]
    result = solve_expr(left, right, operator)
    wires[target] = result
    return solve(exprs, wires, index + 1)

with open("lib/inputs/day24.txt") as f:
    sections = f.read().strip().split("\n\n")
    exprs = [sec.split(" ") for sec in sections[1].split("\n")]
    wires = {}
    for k, v in [sec.split(": ") for sec in sections[0].split("\n")]:
        wires[k] = int(v)

    binary = ""
    for k, v in sorted(solve(exprs, wires, 0).items(), reverse=True):
        if k[0] == 'z':
            binary += str(v)
    part1 = int(binary, 2)
    print(part1)
    
        