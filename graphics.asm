
DATASEG SEGMENT PARA 'DATA'
    pixel_color DB 0FH
    video_segment DW 0A000h
    X1 DB ?
    Y1 DB ?
    X2 DB ?
    Y2 DB ?
DATASEG ENDS

PUBLIC video_segment
PUBLIC pixel_color

CODESEG SEGMENT PARA 'CODE'
    ASSUME DS:DATASEG, CS:CODESEG
    PUBLIC init_graphics
    PUBLIC restore_text_mode
    PUBLIC draw_pixel
    PUBLIC read_pixel
init_graphics PROC FAR
    MOV AX, 0013h   ; set graphic mode to VGA
    INT 10h
    RET
init_graphics ENDP

restore_text_mode PROC FAR
    MOV AX, 0003h
    INT 10h
    RET
restore_text_mode ENDP

read_pixel PROC FAR
    MOV AX, video_segment   ; آدرس سگمنت ویدئویی
    MOV ES, AX

    MOV AX, DX              ; Y را در AX ذخیره کن
    MOV BX, 320             ; عرض صفحه 320 پیکسل است
    MUL BX                  ; AX = Y * 320
    ADD AX, CX              ; محاسبه آدرس نهایی پیکسل
    MOV DI, AX              ; ذخیره در DI

    MOV AL, ES:[DI]         ; خواندن مقدار رنگ پیکسل
    RET
read_pixel ENDP

draw_pixel PROC FAR
    PUSH BP          ; ذخیره مقدار اصلی BP
    MOV BP, SP       ; تنظیم BP برای دسترسی به پارامترهای استک

    MOV AX, 0A000h   ; تنظیم سگمنت گرافیکی
    MOV ES, AX

    MOV CX, [BP+4]   ; مقدار X را از استک بخوان (اولین مقدار بعد از `BP`، یعنی 4 بایت بعد از SP)
    MOV DX, [BP+6]   ; مقدار Y را از استک بخوان (دو بایت بالاتر)

    MOV AX, DX       ; Y را در AX ذخیره کن
    MOV BX, 320      ; عرض صفحه 320 پیکسل است
    MUL BX           ; AX = Y * 320
    ADD AX, CX       ; X را اضافه کن
    MOV DI, AX       ; ذخیره در DI

    MOV AL, 0Fh      ; رنگ سفید
    MOV ES:[DI], AL  ; نوشتن مقدار رنگ در حافظه ویدئویی

    POP BP           ; بازیابی مقدار BP
    RET
draw_pixel ENDP

draw_line PROC FAR
    MOV AX, X2
    SUB AX, X1
    MOV DX, AX      ; dx = X2 - X1

    MOV AX, Y2
    SUB AX, Y1
    MOV BX, AX      ; dy = Y2 - Y1

    SHL BX, 1       ; 2dy
    MOV SI, BX      ; SI = 2dy

    MOV DI, DX
    SHL DI, 1       ; 2dx

    SUB BX, DX      ; D = 2dy - dx

    MOV CX, X1
    MOV DX, Y1

draw_loop:
    PUSH CX         ; X
    PUSH DX         ; Y
    CALL draw_pixel
    POP DX          ; Y
    POP CX          ; X

    CMP CX, X2      ; اگر X به X2 رسید، خروج از حلقه
    JGE end_draw

    INC CX          ; X را افزایش بده

    CMP BX, 0
    JL skip_Y       ; اگر D < 0 بود، فقط X را تغییر بده

    INC DX          ; Y را افزایش بده
    SUB BX, DI      ; D = D - 2dx

skip_Y:
    ADD BX, SI      ; D = D + 2dy
    JMP draw_loop

end_draw:
    RET
draw_line ENDP

CODESEG ENDS

END