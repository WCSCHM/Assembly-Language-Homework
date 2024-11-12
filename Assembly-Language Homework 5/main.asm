.MODEL SMALL
.STACK 100h

.DATA
    ; 年份数据，每个年份占4个字节
    years DB '1975','1976','1977','1978','1979','1980','1981','1982','1983'
          DB '1984','1985','1986','1987','1988','1989','1990','1991','1992'
          DB '1993','1994','1995'

    ; 收入数据，以千美元为单位，使用双字（4字节）以容纳较大的数值
    income DD 16,22,382,1356,2390,8000,16000,24486,50065,97479,140417,197514
          DD 345980,590827,803530,11830,18430,27590,37530,46490,59370

    ; 雇员人数数据，每个雇员人数占2个字节
    employees DW 3,7,9,13,28,38,130,220,476,778,1001,1442,2258,2793,4037,5635,8226,11542,14430,15257,17800

    ; 表格数据，每年记录14字节：4字节年份 + 4字节收入 + 2字节雇员人数 + 4字节人均收入
    table DB 294 DUP('?') ; 初始化表格为问号 (21 * 14 = 294)

    ; 常量
    new_line DB 0Dh,0Ah, '$' ; 换行符
    space DB ' ', '$'         ; 空格

.CODE
EXTRN PRINT_NUMBER:PROC ; 声明外部子程序

MAIN PROC
    ; 初始化段寄存器
    MOV AX, @DATA
    MOV DS, AX

    ; 搬运年份数据到table段
    LEA SI, years        ; DS:SI 指向年份数据
    LEA DI, table        ; DS:DI 指向表格数据

    MOV CX, 21           ; 循环21次
PROCESS_YEARS:
    ; 复制4字节年份
    MOV AL, [SI]
    MOV [DI], AL
    INC SI
    INC DI
    MOV AL, [SI]
    MOV [DI], AL
    INC SI
    INC DI
    MOV AL, [SI]
    MOV [DI], AL
    INC SI
    INC DI
    MOV AL, [SI]
    MOV [DI], AL
    INC SI
    INC DI
    ; 跳过余下的10字节（收入、雇员人数、人均收入）
    ADD DI, 10
    LOOP PROCESS_YEARS

    ; 搬运收入和雇员人数，并计算人均收入
    LEA SI, income        ; DS:SI 指向收入数据
    LEA BX, employees     ; DS:BX 指向雇员人数数据
    LEA DI, table         ; DS:DI 指向表格起始位置
    MOV CX, 21            ; 循环21次

PROCESS_DATA:
    ; 填充收入（双字）
    MOV AX, [SI]          ; 取收入的低字
    MOV [DI+4], AX
    MOV AX, [SI+2]        ; 取收入的高字
    MOV [DI+6], AX
    ADD SI, 4

    ; 填充雇员人数（字）
    MOV AX, [BX]
    MOV [DI+8], AX
    ADD BX, 2

    ; 计算人均收入 = 收入 / 雇员人数
    CMP AX, 0
    JE SKIP_DIVISION      ; 如果雇员人数为零，跳过除法

    ; 使用收入的低字进行除法
    MOV AX, [DI+4]        ; 收入低字
    XOR DX, DX            ; 清除高位
    DIV WORD PTR [DI+8]    ; AX / 雇员人数, 结果在 AX
    MOV [DI+10], AX       ; 存入人均收入低字
    MOV WORD PTR [DI+12], 0 ; 人均收入高字，设为0

SKIP_DIVISION:
    ADD DI, 14            ; 移动到下一个记录
    LOOP PROCESS_DATA

    ; 打印表格数据
    LEA SI, table         ; DS:SI 指向表格数据
    MOV CX, 21            ; 循环21次

PRINT_LOOP:
    ; 打印年份（4字节）
    MOV AH, 02h
    MOV DL, [SI]
    INT 21h
    INC SI
    MOV DL, [SI]
    INT 21h
    INC SI
    MOV DL, [SI]
    INT 21h
    INC SI
    MOV DL, [SI]
    INT 21h
    INC SI

    ; 打印空格
    MOV AH, 02h
    MOV DL, ' '
    INT 21h

    ; 打印收入（双字）
    MOV AX, [SI]          ; 收入低字
    CALL PRINT_NUMBER
    ; 可以选择打印收入高字，简化这里仅打印低字
    ADD SI, 4

    ; 打印空格
    MOV AH, 02h
    MOV DL, ' '
    INT 21h

    ; 打印雇员人数
    MOV AX, [SI]
    CALL PRINT_NUMBER
    ADD SI, 2

    ; 打印空格
    MOV AH, 02h
    MOV DL, ' '
    INT 21h

    ; 打印人均收入
    MOV AX, [SI]
    CALL PRINT_NUMBER
    ADD SI, 4

    ; 打印换行
    LEA DX, new_line
    MOV AH, 09h
    INT 21h

    LOOP PRINT_LOOP

    ; 结束程序
    MOV AX, 4C00h
    INT 21h

MAIN ENDP

END MAIN
