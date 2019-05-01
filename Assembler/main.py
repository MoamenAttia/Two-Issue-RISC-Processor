import sys , os , pathlib

'''
IR (16 bits)
Opcode      Func        Rsrc        Rdst
  2          3           4           4

-----------
One Operand
-----------
NOP
SETC
CLRC
NOT Rdst
INC Rdst
DEC Rdst
OUT Rdst
IN Rdst

-----------
Two Operand
-----------
MOV Rsrc, Rdst
ADD Rsrc, Rdst
SUB Rsrc, Rdst
AND Rsrc, Rdst
OR Rsrc, Rdst
SHL Rsrc, Imm
SHR Rsrc, Imms

-----------
Mem Operand
-----------
PUSH Rdst
POP Rdst
LDM Rdst, Imm
LDD Rsrc, Rdst
STD Rsrc, Rdst

-----------
Jmp Operand
-----------
JZ Rdst
JN Rdst
JC Rdst
JMP Rdst
CALL Rdst
RET
RTI

'''
functionMap = {
    "NOP": "000",
    "SETC": "001",
    "CLRC": "010",
    "NOT": "011",
    "INC": "100",
    "DEC": "101",
    "OUT": "110",
    "IN": "111",
    "MOV": "000",
    "ADD": "001",
    "SUB": "010",
    "AND": "011",
    "OR": "100",
    "SHL": "101",
    "SHR": "110",
    "PUSH": "000",
    "POP": "001",
    "LDM": "010",
    "LDD": "011",
    "STD": "100",
    "JZ": "000",
    "JN": "001",
    "JC": "010",
    "JMP": "011",
    "CALL": "100",
    "RET": "101",
    "RTI": "110"
}
instructionMap = {
    # One Operand
    "NOP": "00",
    "SETC": "00",
    "CLRC": "00",
    "NOT": "00",
    "INC": "00",
    "DEC": "00",
    "OUT": "00",
    "IN": "00",

    # Two Operand
    "MOV": "01",
    "ADD": "01",
    "SUB": "01",
    "AND": "01",
    "OR":  "01",
    "SHL": "01",
    "SHR": "01",

    # Mem Operand
    "PUSH": "10",
    "POP":  "10",
    "LDM":  "10",
    "LDD":  "10",
    "STD":  "10",

    # Jmp Operand
    "JZ":  "11",
    "JN":  "11",
    "JC":  "11",
    "JMP": "11",
    "CALL": "11",
    "RET": "11",
    "RTI": "11"
}
registerMap = {
    "NONE"  : "0000",
    "R0"    : "0001",
    "R1"    : "0010",
    "R2"    : "0011",
    "R3"    : "0100",
    "R4"    : "0101",
    "R5"    : "0110",
    "R6"    : "0111",
    "R7"    : "1000",
    "sp"    : "1001",
    "pc"    : "1010",
    "flag"  : "1011"
}


def assemble(instruction, firstOperand, secondOperand):
    IR = ["0"] * 16
    immediateVal = None

    IR[0] = instructionMap[instruction][0]
    IR[1] = instructionMap[instruction][1]

    IR[2] = functionMap[instruction][0]
    IR[3] = functionMap[instruction][1]
    IR[4] = functionMap[instruction][2]

    if firstOperand != None:
        IR[5] = registerMap[firstOperand][0]
        IR[6] = registerMap[firstOperand][1]
        IR[7] = registerMap[firstOperand][2]
        IR[8] = registerMap[firstOperand][3]
    if secondOperand != None and secondOperand in registerMap.keys():
        IR[9] = registerMap[secondOperand][0]
        IR[10] = registerMap[secondOperand][1]
        IR[11] = registerMap[secondOperand][2]
        IR[12] = registerMap[secondOperand][3]
    elif secondOperand != None and not(secondOperand in registerMap.keys()):
        immediateVal = format(int(secondOperand), '016b')
    elif secondOperand == None:
        IR[9]  = IR[5]
        IR[10] = IR[6]
        IR[11] = IR[7]
        IR[12] = IR[8]
        IR[5]  = IR[6] = IR[7] = IR[8] = "0"
    
    if immediateVal == None:
        return [''.join(IR)]
    else:
        return [''.join(IR), immediateVal]


def writeFile(outputFileName, lines):
    with open(outputFileName, 'w') as file:
        for line in lines:
            file.write(str(line)+'\n')


def readFile(inputFileName):
    file = open(inputFileName, 'r')
    lines = file.readlines()
    binaryCode = []
    for line in lines:
        line = line.strip()
        if len(line) == 0:
            continue
        line = line.upper().split(" ")
        instruction = line[0]
        firstOperand = None
        secondOperand = None
        if len(line) > 1:
            line.append("")
            operands = ''.join(line[1]+line[2]).split(",")
            firstOperand = operands[0]
            if len(operands) > 1:
                secondOperand = operands[1]
        IR = assemble(instruction, firstOperand, secondOperand)
        binaryCode.append(IR[0])
        if len(IR) > 1:
            binaryCode.append(IR[1])
    return binaryCode


if __name__ == "__main__":
    inputFileName = "program.txt"
    outputFileName = "code.txt"
    if (len(sys.argv) > 1):
        inputFileName = sys.argv[1]
    if (len(sys.argv) > 2):
        outputFileName = sys.argv[2]
    lines = readFile(inputFileName)
    writeFile(outputFileName, lines)
