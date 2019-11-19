; Program for linear search

	.model small
	.stack
	.386
	.data
	ARRAY DB 10 DUP(?)

	MESS0 DB 13,10,"ENTER THE NUMBER: $"
	MESS1 DB 13,10,"ENTER THE NUMBER OF ELEMENTS: $"
	MESS2 DB 13,10,"ENTER THE ELEMENT TO BE SEARCHED: $"
	MESS3 DB 13,10,"VALUE FOUND AT LOCATION- $"
	MESS4 DB 13,10,"VALUE NOT FOUND!!!$"

	ErrMess DB 13,10,"ERROR IN INPUT DIGIT$"
	DAT DB ?
	number dw ?

	.code
	.startup

	MOV DX,OFFSET MESS1
	MOV AH,09
	INT 21H

	MOV AH,01
	INT 21H
	cmp al,39h
	jbe abc

	MOV DX,OFFSET ErrMess
	MOV AH,09
	INT 21H
	jmp myexit
	abc:
	and al,0fh
	mov ah,0
	mov number,ax
	MOV CX,AX 
	MOV DI,0

	MYLOOP:
	MOV DX,OFFSET MESS0
	MOV AH,09
	INT 21H
	MOV AH,01
	INT 21H
	cmp al,39h
	jbe abc2
	MOV DX,OFFSET ErrMess
	MOV AH,09
	INT 21H
	jmp myexit

	abc2:
	and al,0fh
	MOV ARRAY[DI],AL
	INC DI
	LOOP MYLOOP

	MOV DX,OFFSET MESS2
	MOV AH,09
	INT 21H
	MOV AH,01
	INT 21H
	cmp al,39h
	jbe abc3
	MOV DX,OFFSET ErrMess
	MOV AH,09
	INT 21H
	jmp myexit

	abc3:
	and al,0fh
	MOV DAT,AL

	mov ax,ds
	mov es,ax
	mov al,dat
	CLD 
	mov cx,number
	INC CX 
	mov DI, offset ARRAY
	repne SCASB

	CMP CX,0
	JE NTFOUND
	MOV DX,OFFSET MESS3
	MOV AH,09
	INT 21H
	SUB NUMBER,CX ;FIND ELEMENT LOCATION
	ADD NUMBER,30H
	MOV DX,NUMBER
	INC DX
	MOV AH,02
	INT 21H
	JMP myexit

	NTFOUND:
	MOV DX,OFFSET MESS4
	MOV AH,09
	INT 21H

	myexit:
	MOV AH,4CH
	INT 21H

	END
