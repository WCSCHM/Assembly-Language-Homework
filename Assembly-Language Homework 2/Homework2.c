#include <stdio.h>

int main() {
    char startChar = 'a';
    int totalLines = 2;
    int charsPerLine = 13;
    int i, j;

    for (i = 0; i < totalLines; i++) {
        for (j = 0; j < charsPerLine; j++) {
            printf("%c", startChar + i * charsPerLine + j);
        }
        printf("\n");
    }

    return 0;
}
/*
main:
    pushq   %rbp                        # 保存旧的基址指针
    movq    %rsp, %rbp                   # 设置新的基址指针
    movb    $97, -1(%rbp)                # startChar = 'a' (ASCII 97)
    movl    $2, -4(%rbp)                 # totalLines = 2
    movl    $13, -8(%rbp)                # charsPerLine = 13
    movl    $0, -12(%rbp)                # i = 0

.L2:
    cmpl    -4(%rbp), -12(%rbp)           # 比较 i 和 totalLines
    jge     .L4                           # 如果 i >= totalLines，跳转到 END
    movl    $0, -16(%rbp)                 # j = 0

.L5:
    cmpl    -8(%rbp), -16(%rbp)           # 比较 j 和 charsPerLine
    jge     .L3                           # 如果 j >= charsPerLine，跳转到 PRINT_NEWLINE
    movzbl  -1(%rbp), %eax                # 加载 startChar 到 %eax
    movl    -12(%rbp), %edx                # 加载 i 到 %edx
    imull   $13, %edx, %eax                # 计算 i * charsPerLine
    addl    -16(%rbp), %eax                 # 加上 j
    addb    $0, %al                        # 确保为字符
    movzbl  %al, %edi                      # 将字符传递给 printf
    movl    $0, %esi                        # 无格式参数
    call    printf                          # 调用 printf 函数
    addl    $1, -16(%rbp)                   # j++
    jmp     .L5                             # 继续内层循环

.L3:
    movl    $10, %edi                       # '\n' 字符
    movl    $0, %esi                        # 无格式参数
    call    printf                           # 调用 printf 输出换行
    addl    $1, -12(%rbp)                    # i++
    jmp     .L2                              # 继续外层循环

.L4:
    movl    $0, %eax                         # 返回值 0
    popq    %rbp                             # 恢复旧的基址指针
    ret                                       # 返回
*/