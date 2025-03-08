from collections import defaultdict

def getAllGroups(connsMap, groups=set()):
    pass

with open("lib/inputs/day23.txt") as f:
    conns = [conn.split("-") for conn in f.read().strip().split()]
    connsMap = defaultdict(set)
    for conn in conns:
        x, y = conn
        connsMap[x].add(y)
        connsMap[y].add(x)

    groups = set()
    for x in connsMap:
        for y in connsMap[x]:
            for z in connsMap[y]:
                if x != z and z in connsMap[x]:
                    groups.add(tuple(sorted([x,y,z])))

    part1 = 0
    for group in groups:
        a, b, c = group
        if a[0] == 't' or b[0] == 't' or c[0] == 't':
            part1 += 1
    print(part1)