.model small
.stack 64
.data
    data db 34H
.code
main proc
    MOV AX, @DATA
    MOV DS, AX
    ;------------
    MOV AH, 4CH
    INT 21h
main endp