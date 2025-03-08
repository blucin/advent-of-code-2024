from functools import cache

with open("lib/inputs/day19_test.txt") as f:
    sections = [section for section in f.read().strip().split("\n\n")]
    stripes, patterns = set(sections[0].split(", ")), sections[1].split("\n")
    print(stripes)
    
    part1 = 0

    @cache
    def checkPattern2(l, r, pattern, formed):
        if l >= len(pattern):
            return True
        if r > len(pattern):
            return False
            
        for tempR in range(r + 1, len(pattern) + 1):
            current = pattern[l:tempR]
            if current in stripes:
                if checkPattern2(tempR, tempR, pattern, formed + current):
                    return True
        return False

    @cache
    def checkPattern3(l, r, pattern, formed):
        if l >= len(pattern):
            return 1
        if r > len(pattern):
            return False
        count = 0            
        for tempR in range(r + 1, len(pattern) + 1):
            current = pattern[l:tempR]
            if current in stripes:
                if checkPattern3(tempR, tempR, pattern, formed + current):
                    count += 1
        return count
    
    part2 = 0 
    for pattern in patterns:
        if checkPattern2(0, 0, pattern, ""):
            part1 += 1
        part2 += checkPattern3(0, 0, pattern, "")

    print(part1)
    print(part2)