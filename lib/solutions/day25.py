with open("lib/inputs/day25.txt") as f:
    sections = [["".join(list(tup)) for tup in list(zip(*sec.split("\n")))] for sec in f.read().strip().split("\n\n")]
    locks = [[sum(1 for c in row if c == '#') - 1 for row in lock] for lock in list(filter(lambda x: x[0][0] == "#", sections))]
    keys = [[sum(1 for c in row if c == "#") - 1 for row in lock] for lock in list(filter(lambda x: (x[0][0] == "."), sections))]

    part1 = 0

    for lock in locks:
        for key in keys:
            _sum = [key[i] + lock[i] for i in range(len(key))]
            for n in _sum:
                if n >= 6:
                    break
            else:
                part1 += 1
    
    print(part1)
            
