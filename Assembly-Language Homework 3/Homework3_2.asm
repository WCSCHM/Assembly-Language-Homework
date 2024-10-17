.MODEL small          ; 定义内存模型为 small
.STACK 100h           ; 分配 256 字节堆栈空间

.DATA
    ; 输入缓冲区结构：
    ; 字节 0：缓冲区大小（最大可输入字符数）
    ; 字节 1：实际输入的字符数（由中断 21h 功能 0Ah 填充）
    ; 字节 2-4：输入的字符（最多 3 个字符，适用于输入 "100"）
    buffer DB 4          ; 缓冲区大小（最大 3 个字符）
           DB ?          ; 实际输入的字符数
           DB 3 DUP(0)    ; 输入字符缓冲区

    ; 输出缓冲区：用于存储输入的字符串并添加字符串终止符 '$'
    output_buffer DB 3 DUP(0), '$'  ; 3 个字符 + '$'

.CODE
main PROC
    ; 初始化数据段
    MOV AX, @DATA
    MOV DS, AX

    ; 调用 DOS 中断 21h 功能 0Ah 进行输入
    ; 读取用户输入的字符串（最多 3 个字符）
    MOV AH, 0Ah          ; 功能号 0Ah：缓冲输入
    LEA DX, buffer       ; DX 指向输入缓冲区
    INT 21h              ; 调用中断

    ; 获取实际输入的字符数
    MOV CL, [buffer+1]   ; CL = 实际输入的字符数
    MOV SI, OFFSET buffer + 2 ; SI 指向输入字符的起始位置

    ; 初始化 DI 指向输出缓冲区
    MOV DI, OFFSET output_buffer

    ; 复制输入字符到输出缓冲区
copy_loop:
    CMP CL, 0            ; 检查是否已复制所有字符
    JE done_copy         ; 如果是，则跳转到 done_copy
    MOV AL, [SI]         ; 读取一个字符
    MOV [DI], AL         ; 写入到输出缓冲区
    INC SI               ; SI 指向下一个输入字符
    INC DI               ; DI 指向下一个输出位置
    DEC CL               ; 减少剩余字符数
    JMP copy_loop        ; 重复循环

done_copy:
    ; 添加字符串终止符 '$'
    MOV BYTE PTR [DI], '$'

    ; 调用 DOS 中断 21h 功能 09h 进行字符串输出
    MOV AH, 09h          ; 功能号 09h：显示字符串
    LEA DX, output_buffer; DX 指向输出字符串
    INT 21h              ; 调用中断

    ; 退出程序
    MOV AH, 4Ch          ; 功能号 4Ch：退出程序
    INT 21h              ; 调用中断

main ENDP
END main
