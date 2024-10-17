; 九九乘法表（上三角形式）
.MODEL SMALL
.STACK 100h

.DATA
    star        DB ' * ', '$'
    equal       DB ' = ', '$'
    space       DB ' ', '$'
    newline     DB 13, 10, '$'        ; CRLF 换行符

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    MOV CX, 1          ; i = 1

outer_loop:
    CMP CX, 10
    JGE end_outer      ; 如果 i > 9，结束外循环

    MOV BX, CX         ; 将 i 存入 BX
    MOV DX, CX         ; j = i

inner_loop:
    CMP DX, 10
    JGE after_inner    ; 如果 j > 9，结束内循环

    PUSH DX            ; 压入 j
    PUSH CX            ; 压入 i
    CALL PrintMul
    ADD SP, 4          ; 清理堆栈（2个参数，每个2字节）

    INC DX             ; j++
    JMP inner_loop

after_inner:
    ; 打印换行符
    LEA DX, newline
    MOV AH, 09h
    INT 21h

    INC CX             ; i++
    JMP outer_loop

end_outer:
    ; 结束程序
    MOV AH, 4Ch
    INT 21h
MAIN ENDP

;-------------------------------------------
; 过程名: PrintMul
; 功能: 打印单个乘法表达式 "j * i = result "
; 参数:
;   [BP + 4]  - j
;   [BP + 6]  - i
;-------------------------------------------
PrintMul PROC
    ; 设置堆栈帧
    PUSH BP
    MOV BP, SP

    ; 保存寄存器
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX

    ; 获取参数
    MOV AX, [BP + 6]    ; i
    MOV BX, [BP + 4]    ; j

    ; 计算 j * i
    MUL BX              ; AX = i * j

    ; 保存结果到 BX
    MOV BX, AX          ; BX = i * j

    ; 打印 j
    MOV AX, [BP + 4]    ; j
    MOV CX, AX
    CALL PrintNum

    ; 打印 " * "
    LEA DX, star
    MOV AH, 09h
    INT 21h

    ; 打印 i
    MOV AX, [BP + 6]    ; i
    MOV CX, AX
    CALL PrintNum

    ; 打印 " = "
    LEA DX, equal
    MOV AH, 09h
    INT 21h

    ; 打印结果 (i * j)
    MOV AX, BX          ; BX = i * j
    MOV CX, AX
    CALL PrintNum

    ; 打印一个空格
    LEA DX, space
    MOV AH, 09h
    INT 21h

    ; 恢复寄存器
    POP DX
    POP CX
    POP BX
    POP AX

    ; 恢复堆栈帧并返回
    POP BP
    RET 4                ; 返回并清理4字节参数
PrintMul ENDP

;-------------------------------------------
; 过程名: PrintNum
; 功能: 打印数字（在 CX 中）
;-------------------------------------------
PrintNum PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX

    MOV AX, 0
    MOV BX, 10
    MOV DI, 0          ; DI 作为计数器

    CMP CX, 0
    JNE ConvertNum
    MOV DL, '0'
    MOV AH, 02h
    INT 21h
    JMP PrintDone

ConvertNum:
    MOV AX, CX
    MOV DI, 0          ; DI 作为计数器

convert_loop:
    XOR DX, DX
    DIV BX             ; AX = AX / 10, DX = AX % 10
    ADD DL, '0'        ; 将余数转换为ASCII字符
    PUSH DX            ; 保存字符
    INC DI
    CMP AX, 0
    JNE convert_loop

    ; 打印数字字符
print_loop:
    POP DX
    MOV DL, DL         ; DL 已经包含要打印的字符
    MOV AH, 02h
    INT 21h
    DEC DI
    JNZ print_loop

PrintDone:
    POP DX
    POP CX
    POP BX
    POP AX
    RET
PrintNum ENDP

END MAIN
