import re

a, b, c, *program = map(int, re.findall(r"\d+", open("lib/inputs/day17.txt").read()))

pointer = 0
output = []
print(program)
def combo(operand):
    if 0 <= operand <= 3: return operand
    if operand == 4: return a
    if operand == 5: return b
    if operand == 6: return c
    raise AssertionError(f"unrecognized combo operand {operand}")

while pointer < len(program):
    ins = program[pointer]
    operand = program[pointer + 1]
    if ins == 0: # adv
        a = a >> combo(operand)
    elif ins == 1: # bxl
        b = b ^ operand
    elif ins == 2: # bst
        b = combo(operand) % 8
    elif ins == 3: # jnz
        if a != 0:
            pointer = operand
            continue
    elif ins == 4: # bxc
        b = b ^ c
    elif ins == 5: # out
        output.append(combo(operand) % 8)
    elif ins == 6: # bdv
        b = a >> combo(operand)
    elif ins == 7: # cdv
        c = a >> combo(operand)
    pointer += 2

print(*output, sep=",")

part2 = 0
for possibleA in range(36000000000000, 1000000000000000):
    pointer = 0
    a = possibleA
    b = 0
    c = 0
    output = []
    while pointer < len(program):
        ins = program[pointer]
        operand = program[pointer + 1]
        if ins == 0: # adv
            a = a >> combo(operand)
        elif ins == 1: # bxl
            b = b ^ operand
        elif ins == 2: # bst
            b = combo(operand) % 8
        elif ins == 3: # jnz
            if a != 0:
                pointer = operand
                continue
        elif ins == 4: # bxc
            b = b ^ c
        elif ins == 5: # out
            output.append(combo(operand) % 8)
        elif ins == 6: # bdv
            b = a >> combo(operand)
        elif ins == 7: # cdv
            c = a >> combo(operand)
        pointer += 2
        
    percetage = (possibleA / 1000000000000000) * 100
    print(f"{percetage:.2f}%: {possibleA} -> {output}")

    if output == program:
        part2 = possibleA
        break

print(part2) 