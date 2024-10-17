.MODEL SMALL
.STACK 100h

.DATA
    buffer_reg    DB '0000$'      ; 存储寄存器中结果的字符串
    buffer_data   DB '0000$'      ; 存储数据段中结果的字符串
    buffer_stack  DB '0000$'      ; 存储栈中结果的字符串
    sum_data      DW 0             ; 存储数据段中的和

.CODE
MAIN PROC
    ; 初始化数据段
    MOV AX, @DATA
    MOV DS, AX

    ; 初始化计数器和和
    MOV CX, 100        ; 循环计数器，从100递减到1
    MOV BX, 0          ; 用于存储和的寄存器，初始为0

SUM_LOOP:
    ADD BX, CX         ; 将当前计数器值加到和中
    DEC CX             ; 计数器减1
    JNZ SUM_LOOP       ; 如果计数器不为0，继续循环

    ; 1. 存储在寄存器中（AX）
    MOV AX, BX         ; 将和从BX移动到AX

    ; 2. 存储在数据段中
    MOV sum_data, BX   ; 将和存储到数据段变量中

    ; 3. 存储在栈中
    PUSH BX            ; 将和压入栈

    ; --- 打印寄存器中的结果 ---
    ; AX 已经包含和
    ; 将 AX 的值转换为字符串存储到 buffer_reg
    MOV AX, AX         ; 确保AX未被修改
    MOV CX, 0          ; 初始化数字计数
    LEA DI, buffer_reg + 3 ; 指向缓冲区的最后一位
    MOV BYTE PTR [DI+1], '$'  ; 设置字符串结束符

CONVERT_REG_LOOP:
    XOR DX, DX         ; 清除DX以确保高位为0
    MOV BX, 10         ; 除数为10
    DIV BX             ; AX / 10，商存回AX，余数在DX
    ADD DL, '0'        ; 将余数转换为ASCII字符
    MOV [DI], DL       ; 存储字符到缓冲区
    DEC DI             ; 移动到前一位
    INC CX             ; 记录数字位数
    CMP AX, 0
    JNZ CONVERT_REG_LOOP   ; 如果商不为0，继续转换

FILL_REG_ZERO:
    CMP CX, 4
    JGE PRINT_REG_RESULT    ; 如果已经有4位或更多，跳过填充
    MOV BYTE PTR [DI], '0'
    DEC DI
    INC CX
    JMP FILL_REG_ZERO

PRINT_REG_RESULT:
    LEA DX, buffer_reg    ; DX指向寄存器结果字符串
    MOV AH, 09h           ; DOS功能：显示字符串
    INT 21h

    ; 换行
    MOV AH, 02h
    MOV DL, 0Dh
    INT 21h
    MOV DL, 0Ah
    INT 21h

    ; --- 打印数据段中的结果 ---
    ; 从 sum_data 读取和
    MOV AX, sum_data
    MOV CX, 0          ; 初始化数字计数
    LEA DI, buffer_data + 3 ; 指向缓冲区的最后一位
    MOV BYTE PTR [DI+1], '$'  ; 设置字符串结束符

CONVERT_DATA_LOOP:
    XOR DX, DX         ; 清除DX以确保高位为0
    MOV BX, 10         ; 除数为10
    DIV BX             ; AX / 10，商存回AX，余数在DX
    ADD DL, '0'        ; 将余数转换为ASCII字符
    MOV [DI], DL       ; 存储字符到缓冲区
    DEC DI             ; 移动到前一位
    INC CX             ; 记录数字位数
    CMP AX, 0
    JNZ CONVERT_DATA_LOOP   ; 如果商不为0，继续转换

FILL_DATA_ZERO:
    CMP CX, 4
    JGE PRINT_DATA_RESULT    ; 如果已经有4位或更多，跳过填充
    MOV BYTE PTR [DI], '0'
    DEC DI
    INC CX
    JMP FILL_DATA_ZERO

PRINT_DATA_RESULT:
    ; 显示数据段中的结果
    LEA DX, buffer_data    ; DX指向数据段结果字符串
    MOV AH, 09h           ; DOS功能：显示字符串
    INT 21h

    ; 换行
    MOV AH, 02h
    MOV DL, 0Dh
    INT 21h
    MOV DL, 0Ah
    INT 21h

    ; --- 打印栈中的结果 ---
    ; 从栈中弹出和
    POP BX              ; 将和从栈中弹出到BX
    MOV AX, BX          ; 将和移动到AX

    MOV CX, 0          ; 初始化数字计数
    LEA DI, buffer_stack + 3 ; 指向缓冲区的最后一位
    MOV BYTE PTR [DI+1], '$'  ; 设置字符串结束符

CONVERT_STACK_LOOP:
    XOR DX, DX         ; 清除DX以确保高位为0
    MOV BX, 10         ; 除数为10
    DIV BX             ; AX / 10，商存回AX，余数在DX
    ADD DL, '0'        ; 将余数转换为ASCII字符
    MOV [DI], DL       ; 存储字符到缓冲区
    DEC DI             ; 移动到前一位
    INC CX             ; 记录数字位数
    CMP AX, 0
    JNZ CONVERT_STACK_LOOP   ; 如果商不为0，继续转换

FILL_STACK_ZERO:
    CMP CX, 4
    JGE PRINT_STACK_RESULT    ; 如果已经有4位或更多，跳过填充
    MOV BYTE PTR [DI], '0'
    DEC DI
    INC CX
    JMP FILL_STACK_ZERO

PRINT_STACK_RESULT:
    ; 显示栈中的结果
    LEA DX, buffer_stack    ; DX指向栈中结果字符串
    MOV AH, 09h             ; DOS功能：显示字符串
    INT 21h

    ; 程序退出
    MOV AH, 4Ch           ; DOS功能：退出程序
    INT 21h

MAIN ENDP

END MAIN
