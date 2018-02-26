DATA SEGMENT
	X DB 0,0,0,0,0,0,0,0,0,0,255,255,255,255,255,255,255,255,255,255
	Y DB 128,168,203,232,250,255,250,232,203,168,128,88,53,24,6,0,6,24,53,88
	S DB 'SINE WAVE (Y/N):$'
	N DB 0
	IOPORT EQU 208H
DATA ENDS

STACK SEGMENT STACK
	DB 100 DUP(0)
STACK ENDS

CODE SEGMENT
MAIN PROC
	MOV AX, DATA
	MOV DS, AX
	LEA DX, S
	MOV AH, 9
	INT 21H
	MOV AH, 1
	INT 21H
	LEA BX, N
	MOV [BX], OFFSET Y
	CMP AL, 'Y'
	JZ NEXT1
	MOV [BX], OFFSET X
NEXT1:MOV SI, [BX]
	MOV DX, IOPORT
	MOV CX, 20
NEXT2:MOV AL, [SI]
	OUT DX, AL
	CALL DELAY
	INC SI
	LOOP NEXT2
	MOV AH, 6
	MOV DL, 0FFH
	INT 21H
	JZ NEXT1
	MOV AH, 4CH
	INT 21H
MAIN ENDP
DELAY PROC
	PUSH CX
	PUSH BX
	MOV BX, 0001H
	NEXT9:MOV CX, 00FFH
	NEXT8: LOOP NEXT8
	DEC BX
	CMP BX, 0
	JNZ NEXT9
	POP BX
	POP CX
	RET
DELAY ENDP
CODE ENDS
	END MAIN
