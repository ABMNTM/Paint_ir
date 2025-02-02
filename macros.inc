check_right_click MACRO label
    MOV AX, CX
    MOV CL, 2
    SHR BX, CL
    MOV CX, AX
    JNC label
ENDM

check_left_click MACRO label
    MOV AX, CX
    MOV CL, 1
    SHR BX, CL
    MOV CX, AX
    JNC label
ENDM