CODESEG SEGMENT PARA 'CODE'
    ASSUME CS:CODESEG

    PUBLIC check_exit
    PUBLIC exit_program

check_exit PROC FAR
    MOV AH, 1
    INT 16h
    RET
check_exit ENDP

exit_program PROC FAR
    MOV AH, 4Ch
    INT 21h
exit_program ENDP

CODESEG ENDS
END