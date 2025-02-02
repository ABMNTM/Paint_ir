DATASEG SEGMENT PARA 'DATA'
    OLD_COLOR DB 0
    EXTRN pixel_color:BYTE
DATASEG ENDS

CODESEG SEGMENT PARA 'CODE'
    ASSUME CS:CODESEG, DS:DATASEG

    PUBLIC enable_mouse
    PUBLIC get_mouse_position
    PUBLIC draw_mouse
    PUBLIC erase_mouse
    EXTRN draw_pixel:FAR
    EXTRN read_pixel:FAR

enable_mouse PROC FAR
    MOV AX, 0
    INT 33h
    RET
enable_mouse ENDP

get_mouse_position PROC FAR
    MOV AX, 3
    INT 33h
    RET
get_mouse_position ENDP

CODESEG ENDS
END