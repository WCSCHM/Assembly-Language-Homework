.MODEL SMALL
.STACK 100h

.DATA
; 定义 9x9 乘法表数据
table DB 7,2,3,4,5,6,7,8,9             ; 第1行
      DB 2,4,7,8,10,12,14,16,18      ; 第2行
      DB 3,6,9,12,15,18,21,24,27      ; 第3行
      DB 4,8,12,16,7,24,28,32,36      ; 第4行
      DB 5,10,15,20,25,30,35,40,45    ; 第5行
      DB 6,12,18,24,30,7,42,48,54      ; 第6行
      DB 7,14,21,28,35,42,49,56,63    ; 第7行
      DB 8,16,24,32,40,48,56,7,72      ; 第8行
      DB 9,18,27,36,45,54,63,72,8      ; 第9行

newline DB 13,10, '$'                   ; 换行符
msg     DB 'Incorrect entry at row: $'
msg2    DB ', column: $'

.CODE
MAIN PROC
    ; 初始化数据段寄存器
    MOV AX, @DATA
    MOV DS, AX

    ; 初始化指针和行号
    LEA SI, table        ; SI 指向表的起始位置
    MOV BL, 1            ; 行号从1到9

OUTER_LOOP:
    ; 检查是否超过第9行
    CMP BL, 10
    JGE END_PROGRAM      ; 如果行号 >=10，结束程序

    ; 初始化列号
    MOV BH, 1            ; 列号从1到9
    MOV CX, 9            ; 列循环计数器

INNER_LOOP:
    ; 读取当前单元格的值
    MOV AL, [SI]

    ; 计算期望值 = 行号 * 列号
    MOV DL, BL           ; DL = 行号
    MOV DH, BH           ; DH = 列号
    MOV AH, 0
    MOV AL, DL
    MUL DH               ; AX = DL * DH
    ; 期望值现在在 AL 中

    ; 比较期望值和实际值
    CMP AL, [SI]
    JE NO_MISMATCH       ; 如果匹配，跳过错误处理

    ; 如果不匹配，输出错误信息
    ; 输出 "Incorrect entry at row: "
    MOV AH, 09h
    LEA DX, msg
    INT 21h

    ; 输出行号
    MOV AL, BL
    ADD AL, '0'          ; 转换为ASCII
    MOV DL, AL
    MOV AH, 02h
    INT 21h

    ; 输出 ", column: "
    MOV AH, 09h
    LEA DX, msg2
    INT 21h

    ; 输出列号
    MOV AL, BH
    ADD AL, '0'          ; 转换为ASCII
    MOV DL, AL
    MOV AH, 02h
    INT 21h

    ; 输出换行符
    MOV AH, 09h
    LEA DX, newline
    INT 21h

NO_MISMATCH:
    ; 移动到下一个单元格
    INC SI
    INC BH
    LOOP INNER_LOOP      ; 检查下一列

    ; 移动到下一行
    INC BL               ; 增加行号
    JMP OUTER_LOOP       ; 继续外层循环

END_PROGRAM:
    ; 程序结束，退出
    MOV AH, 4Ch
    INT 21h
MAIN ENDP
END MAIN
