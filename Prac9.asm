.MODEL SMALL
.386
.DATA
ARRAY1 DB 50 DUP(?)
ARRAY2 DB 50 DUP(?)
RESULT DB 50 DUP(?)
M0 DB 10,13,'PROGRAM TO ADD 2 ARRAYS$'
M1 DB 10,13,'ENTER THE SIZE OF ARRAYS$'
M2 DB 10,13,'ENTER DIGIT$'
M3 DB 10,13,'ENTER ELEMENT OF ARRAY1$'
M4 DB 10,13,'ENTER ELEMENT OF ARRAY2$'
M5 DB 10,13,'RESULTING ARRAY$'
NUM DW 0H

.CODE
.STARTUP

MOV AX,0H
MOV CX,0H
MOV DI,0H
MOV BX,0H

MOV AH,9
MOV DX,OFFSET M0
INT 21H

MOV AH,9
MOV DX,OFFSET M1
INT 21H
 
MOV AH,1
INT 21H
SUB AL,30H
MOV AH,0
MOV NUM,AX
MOV DI,0H
MOV CX,NUM

MOV AH,9
MOV DX,OFFSET M3
INT 21H

L1:MOV AH,9
MOV DX,OFFSET M2
INT 21H

MOV AH,1
INT 21H
SUB AL,30H
MOV ARRAY1[DI],AL
INC DI
LOOP L1

MOV DI,0
MOV CX,NUM

MOV AH,9
MOV DX,OFFSET M4
INT 21H

L2:MOV AH,9
MOV DX,OFFSET M2
INT 21H

MOV AH,1
INT 21H
SUB AL,30H
MOV ARRAY2[DI],AL
INC DI
LOOP L2

MOV DI,0
MOV CX,NUM

L3:
MOV DL,ARRAY1[DI]
 
ADD DL,ARRAY2[DI]
MOV RESULT[DI],DL
INC DI
LOOP L3

MOV AH,9
MOV DX,OFFSET M5
INT 21H

MOV DI,0
MOV CX,NUM

MOV AH,0H
L7: MOV AL,RESULT[DI]
INC DI
CALL DISPH
LOOP L7
.EXIT
DISPH	PROC NEAR

PUSH AX
PUSH CX
MOV CL,4
MOV CH,4

DISPH1:
ROL AX,CL
PUSH EAX
AND AL,0FH
ADD AL,30H
CMP AL,'9'
JBE DISPH2
ADD AL,7

DISPH2:
MOV AH,2
MOV DL,AL
INT 21H
POP EAX 
DEC CH
JNZ DISPH1
POP CX
POP BX
RET
 

DISPH	ENDP
END