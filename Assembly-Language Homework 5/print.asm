.MODEL SMALL
.STACK 100h

.CODE
PUBLIC PRINT_NUMBER ; 声明子程序为公开，以便主程序引用

PRINT_NUMBER PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX

    ; 检查是否为零
    CMP AX, 0
    JNE CONVERT_NUMBER
    ; 如果为零，直接打印字符 '0'
    MOV DL, '0'
    MOV AH, 02h
    INT 21h
    JMP PRINT_DONE

CONVERT_NUMBER:
    ; 将 AX 中的数字转换为字符串并存储在堆栈
    XOR CX, CX
CONVERT_LOOP:
    XOR DX, DX
    MOV BX, 10
    DIV BX                ; AX / 10, 商存回 AX，余数存入 DX
    PUSH DX               ; 将余数（数字）压入堆栈
    INC CX
    TEST AX, AX
    JNZ CONVERT_LOOP

PRINT_DIGITS:
    POP DX
    ADD DL, '0'           ; 转换为ASCII字符
    MOV AH, 02h           ; DOS 打印字符功能
    INT 21h
    LOOP PRINT_DIGITS

PRINT_DONE:
    POP DX
    POP CX
    POP BX
    POP AX
    RET
PRINT_NUMBER ENDP

END
