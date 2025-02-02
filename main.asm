INCLUDE macros.inc

STACKSEG SEGMENT STACK
    DW 100h DUP(?)
STACKSEG ENDS

DATASEG SEGMENT PARA 'DATA'
    EXTRN video_segment:WORD
    EXTRN pixel_color:BYTE
DATASEG ENDS

CODESEG SEGMENT PARA 'CODE'
    ASSUME CS:CODESEG, SS:STACKSEG, DS:DATASEG

    EXTRN init_graphics:FAR
    EXTRN restore_text_mode:FAR
    EXTRN enable_mouse:FAR
    EXTRN get_mouse_position:FAR
    EXTRN draw_pixel:FAR
    EXTRN check_exit:FAR
    EXTRN exit_program:FAR

MAIN PROC NEAR
    MOV AX, DATASEG
    MOV DS, AX
    MOV ES, AX
    MOV AX, STACKSEG
    MOV SS, AX
    MOV SP, 100H

    CALL init_graphics
    CALL enable_mouse
    
    MOV pixel_color, 0DH

loop_start:
    CALL get_mouse_position

    CMP CX, 320
    JA loop_start
    CMP DX, 200
    JA loop_start

    check_right_click next
    CALL draw_pixel

next:
    CALL check_exit
    JZ loop_start

    CALL restore_text_mode
    CALL exit_program
MAIN ENDP
CODESEG ENDS
END MAIN
