#include <stdio.h>
int main() {
    int sum = 0;         
    for (int i = 1; i <= 100; i++) { 
        sum += i;        
    }
    printf("Sum: %d\n", sum); 
    return 0;             
}
/*
section .data
    format db "Sum: %d", 10, 0  ; 定义输出格式字符串 "Sum: %d\n"

section .bss
    ; 没有未初始化的数据

section .text
    global main
    extern printf

main:
    push ebp                ; 保存旧的基址指针
    mov ebp, esp            ; 设置新的基址指针
    sub esp, 8              ; 为局部变量分配空间（sum和i）

    mov DWORD [ebp-4], 0    ; 将sum初始化为0
    mov DWORD [ebp-8], 1    ; 将i初始化为1

.L2:
    mov eax, [ebp-8]        ; 将i的值加载到eax
    cmp eax, 100            ; 比较i是否大于100
    jg .L4                  ; 如果i > 100，跳转到.L4

    mov eax, [ebp-4]        ; 将sum的当前值加载到eax
    add eax, [ebp-8]        ; 将i的值加到eax
    mov [ebp-4], eax        ; 将新的sum值存回

    add DWORD [ebp-8], 1    ; 将i递增1
    jmp .L2                 ; 跳回循环开始

.L4:
    push DWORD [ebp-4]      ; 将sum的值压栈作为printf的参数
    push format             ; 将格式字符串的地址压栈
    call printf             ; 调用printf函数
    add esp, 8              ; 清理堆栈（2个参数，每个4字节）

    mov eax, 0              ; 将返回值0放入eax
    leave                   ; 恢复旧的基址指针和栈指针
    ret                     ; 返回调用者

*/