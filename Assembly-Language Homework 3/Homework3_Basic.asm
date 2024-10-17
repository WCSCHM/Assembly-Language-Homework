.MODEL SMALL
.STACK 100h

.DATA
    buffer DB '0000$'      ; 存储转换后的字符串，预留4位数字
    sum     DW 0             ; 存储求和结果

.CODE
MAIN PROC
    ; 初始化数据段
    MOV AX, @DATA
    MOV DS, AX

    ; 初始化计数器和和
    MOV CX, 100        ; 循环计数器，从100递减到1
    MOV BX, 0          ; 存储和的寄存器，初始为0

SUM_LOOP:
    ADD BX, CX         ; 将当前计数器值加到和中
    DEC CX             ; 计数器减1
    JNZ SUM_LOOP       ; 如果计数器不为0，继续循环

    ; 将和存储到变量sum中
    MOV sum, BX

    ; 将和转换为十进制字符串
    MOV AX, BX         ; 将和加载到AX中
    MOV CX, 0          ; 初始化数字计数
    MOV DI, OFFSET buffer + 3 ; 指向缓冲区的最后一位
    MOV BYTE PTR [DI+1], '$'  ; 设置字符串结束符

CONVERT_LOOP:
    XOR DX, DX         ; 清除DX以确保高位为0
    MOV BX, 10         ; 除数为10
    DIV BX             ; AX / 10，结果存回AX，余数在DX
    ADD DL, '0'        ; 将余数转换为ASCII字符
    MOV [DI], DL       ; 存储字符到缓冲区
    DEC DI             ; 移动到前一位
    INC CX             ; 记录数字位数
    CMP AX, 0
    JNZ CONVERT_LOOP   ; 如果商不为0，继续转换

    ; 填充剩余位为'0'（如果有需要）
FILL_ZERO:
    CMP CX, 4
    JGE PRINT_RESULT    ; 如果已经有4位或更多，跳过填充
    MOV BYTE PTR [DI], '0'
    DEC DI
    INC CX
    JMP FILL_ZERO

PRINT_RESULT:
    ; 显示结果字符串
    MOV DX, OFFSET buffer ; DX指向字符串开始位置
    MOV AH, 09h           ; DOS功能：显示字符串
    INT 21h

    ; 程序退出
    MOV AH, 4Ch           ; DOS功能：退出程序
    INT 21h
MAIN ENDP

END MAIN
