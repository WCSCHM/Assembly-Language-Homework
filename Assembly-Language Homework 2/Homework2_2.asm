.MODEL SMALL
.STACK 100h

.DATA
    startChar     DB 'a'                ; 起始字符
    newline       DB 0Dh, 0Ah, '$'      ; 换行符
    rowCount      DW 2                  ; 总行数
    colCount      DW 13                 ; 每行字符数
    rowCounter    DW 0                  ; 当前行数
    colCounter    DW 0                  ; 当前列数

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    MOV BL, startChar          ; 字符起始值
    MOV word ptr rowCounter, 0 ; 初始化行计数器

PRINT_LOOP:
    ; 将 rowCounter 加载到 AX 寄存器
    MOV AX, word ptr rowCounter
    CMP AX, rowCount
    JGE END_PRINT              ; 如果当前行数 >= 总行数，结束打印

    MOV word ptr colCounter, 0 ; 初始化列计数器

PRINT_CHAR_LOOP:
    ; 将 colCounter 加载到 AX 寄存器
    MOV AX, word ptr colCounter
    CMP AX, colCount
    JGE PRINT_NEWLINE          ; 如果当前列数 >= 每行字符数，跳转到换行

    MOV DL, BL                 ; 将当前字符存入 DL
    MOV AH, 02h                ; DOS 功能：显示字符
    INT 21h

    INC BL                     ; 下一个字符
    INC word ptr colCounter    ; 列计数器加 1
    JMP PRINT_CHAR_LOOP        ; 跳回继续打印下一个字符

PRINT_NEWLINE:
    LEA DX, newline
    MOV AH, 09h                ; DOS 功能：显示字符串
    INT 21h

    INC word ptr rowCounter    ; 行数加 1
    JMP PRINT_LOOP             ; 跳回继续打印下一行

END_PRINT:
    MOV AH, 4Ch                ; DOS 功能：退出程序
    INT 21h

MAIN ENDP
END MAIN
