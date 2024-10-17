.MODEL SMALL
.STACK 100h
.DATA
    startChar DB 'a'        ; 起始字符
    newline  DB 0Dh, 0Ah, '$' ; 换行符

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    MOV CX, 2              ; 外层循环次数（两行）
    MOV BL, 'a'            ; 字符起始值

OUTER_LOOP:
    PUSH CX                ; 保存外层CX
    MOV CX, 13             ; 内层循环次数（每行13个字符）

INNER_LOOP:
    MOV DL, BL             ; 将当前字符存入DL
    MOV AH, 02h            ; DOS功能：显示字符
    INT 21h

    INC BL                 ; 下一个字符
    LOOP INNER_LOOP        ; 内层循环

    MOV AH, 09h            ; 显示换行符
    LEA DX, newline
    INT 21h

    POP CX                 ; 恢复外层CX
    LOOP OUTER_LOOP        ; 外层循环

    MOV AH, 4Ch            ; 退出程序
    INT 21h
MAIN ENDP
END MAIN
