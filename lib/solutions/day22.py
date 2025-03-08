from collections import defaultdict

def mix(secret, val):
    return secret ^ val

def prune(secret):
    return secret % 16777216

def operation(secret):
    operation1 = prune(mix(secret, secret * 64))
    operation2 = prune(mix(operation1, operation1 // 32))
    operation3 = prune(mix(operation2, operation2 * 2048))
    return operation3

with open("lib/inputs/day22.txt") as f:
    nums = list(map(int, f.read().strip().split("\n")))
    part1 = 0
    changesToBanana = defaultdict(int)
    for num in nums:
        history = [num % 10]
        changes = []
        for _ in range(2000):
            num = operation(num)
            changes.append(num % 10 - history[-1])
            history.append(num % 10)
        part1 += num

        seen = set() 
        for i in range(len(changes) - 4):
            currSeq = tuple(changes[i:i+4])
            if currSeq in seen: continue
            seen.add(currSeq)
            changesToBanana[currSeq] += history[i+4]
            
    part2 = max(changesToBanana.values())
    
    print(part1)
    print(part2)