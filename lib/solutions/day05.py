from collections import defaultdict

with open("lib/inputs/day05_test.txt") as file:
    rules, updates = [sections.split("\n") for sections in file.read().strip().split("\n\n")]
    updates = [[int(x) for x in update.split(',')] for update in updates]
    
    rule_map = defaultdict(set)
    for rule in rules:
        before, after = map(int, rule.split("|"))
        rule_map[before].add(after)
        
    valid_updates = []
    invalid_updates = []
    for update in updates:
        is_valid = True
        for i in range(len(update)-1):
            afters = rule_map[update[i]]
            if update[i+1] not in afters:
                is_valid = False
                invalid_updates.append(update)
                break
        if is_valid:
            valid_updates.append(update)
    
    print(invalid_updates) 
            
    def is_valid_order(a, b, rule_map):
        return b in rule_map[a]

    sorted_updates = []
    for update in invalid_updates:
        sorted_list = update.copy()
        n = len(sorted_list)
        for i in range(n):
            for j in range(0, n-i-1):
                if not is_valid_order(sorted_list[j], sorted_list[j+1], rule_map):
                    sorted_list[j], sorted_list[j+1] = sorted_list[j+1], sorted_list[j]
        sorted_updates.append(sorted_list)
    print(sorted_updates)
            
    part1 = 0
    for update in valid_updates:
        mid = len(update) // 2
        part1 += update[mid]
    print(part1)
    
    part2 = 0
    for update in sorted_updates:
        mid = len(update) // 2
        part2 += update[mid]
    print(part2)

