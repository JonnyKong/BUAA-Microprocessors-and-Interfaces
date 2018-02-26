STACKS SEGMENT STACK
    DB 00FFH DUP(0)
STACKS ENDS

DATAS SEGMENT
    X1 DB 4 DUP(0)
    X2 DB 4 DUP(0)
    X3 DB 5 DUP(0)
DATAS ENDS

CODES SEGMENT
    ASSUME CS:CODES, DS:DATAS, SS:STACKS
        
MAIN PROC
;INPUT X1
    LEA BX, X1
    MOV CX, 4
NEXT:CALL KEYIN
    AND AL, 0FH
    MOV [BX], AL
    INC BX
    LOOP NEXT
;+ SIGN
    MOV DL, '+'
    MOV AH, 2
    INT 21H
;INPUT X2
    LEA BX, X2
    MOV CX, 4
NEXT2:CALL KEYIN
    AND AL, 0FH
    MOV [BX], AL
    INC BX
    LOOP NEXT2
;'='SIGN
    MOV DL, '='
    MOV AH, 2
    INT 21H
;CALCULATE
    LEA SI, X1 + 3
    LEA DI, X2 + 3
    LEA BX, X3 + 4
    MOV CX, 4
    OR CX, CX   ;CLEAR CF
NEXT3:MOV AL, [SI]
    ADC AL, [DI]
    AAA
    MOV[BX], AL
    DEC SI
    DEC DI
    DEC BX
    LOOP NEXT3
;LAST DIGIT
    MOV AL, 0
    ADC AL, 0
    MOV [BX], AL
;DISP
    CMP AL, 0
    JE NEXT4 ;SKIP FIRST 0
    ADD [BX], 30H
    MOV DL, [BX]
    MOV AH, 2
    INT 21H
NEXT4:
    INC BX
    MOV CX, 4
NEXT5:
    ADD [BX], 30H
    MOV DL, [BX]
    MOV AH, 2
    INT 21H
    INC BX
    LOOP NEXT5
;END PROGRAM
    MOV AH, 4CH
    INT 21H
MAIN ENDP

KEYIN PROC
AGAIN:MOV AH, 8
    INT 21H
    CMP AL, 30H
    JB AGAIN
    CMP AL, 39H
    JA AGAIN
    MOV DL, AL
    MOV AH, 2
    INT 21H
    RET
KEYIN ENDP

CODES ENDS
    END MAIN