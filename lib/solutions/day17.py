import re

'''
InstrPtr: 0
++2
Halt on ottb

Operands:
    1. Literal operand: name is the value "7" -> 7
    2. Combo operand:
        "0", "1", "2", "3" -> literal operands
        "4" -> regA as an operand
        "5" -> regB as an operand
        "6" -> regC as an operand
        "7" -> reserved, will not appear in the program

opcode:
    0 -> adv: regA = truncint(regA / val^2)
    1 -> bxl: regB = regB xor val
    2 -> bst: regB = val modulo 8 <- lowest 3 bits
    3 -> jnz: pass if regA == 0 else jump(val)
    4 -> bxc: regB = regB bitwiseXOR regC; ignore val
    5 -> out: result += val modulo 8
    6 -> bdv: regB = truncint(regA / val^2)
    7 -> cdv: regC = truncint(regA / val^2)
'''

def runProgram(program, ra, rb, rc):
    ip = 0
    part1 = []

    def combo(val):
        if 0 <= val <= 3:
            return val
        elif val == 4: return ra
        elif val == 5: return rb
        elif val == 6: return rc
        else: raise ValueError("Invalid combo operand")

    while ip < len(program):
        opcode = program[ip]
        operand = program[ip + 1]

        match opcode:
            case 0:
                ra = ra >> combo(operand)
            case 1:
                rb = rb ^ operand
            case 2:
                rb = combo(operand) % 8
            case 3:
                if ra != 0:
                    ip = operand
                    continue
            case 4:
                rb = rb ^ rc
            case 5:
                part1.append(combo(operand) % 8)
            case 6:
                rb = ra >> combo(operand)
            case 7:
                rc = ra >> combo(operand)
        ip += 2
        
    return part1


with open("lib/inputs/day17.txt") as f:
    input = f.read().strip().split("\n\n")
    ra, rb, rc = list(map(int, [regline.split(" ")[2] for regline in input[0].split("\n")]))
    program = list(map(int, input[1].split(" ")[1].split(",")))
    
    part1 = runProgram(program, ra, rb, rc)
    print(*part1, sep=",")
    
    part2 = 0
    for possibleA in range(0, 1000000000000000):
        output = runProgram(program, possibleA, rb, rc)
        if output == program:
            part2 = possibleA
            break
        percentage = (possibleA / 1000000000000000) * 100
        print(f"\rProgress: {percentage:.2f}%", end='', flush=True)
    print(part2)
        