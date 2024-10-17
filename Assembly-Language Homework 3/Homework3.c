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
    format db "Sum: %d", 10, 0  ; ���������ʽ�ַ��� "Sum: %d\n"

section .bss
    ; û��δ��ʼ��������

section .text
    global main
    extern printf

main:
    push ebp                ; ����ɵĻ�ַָ��
    mov ebp, esp            ; �����µĻ�ַָ��
    sub esp, 8              ; Ϊ�ֲ���������ռ䣨sum��i��

    mov DWORD [ebp-4], 0    ; ��sum��ʼ��Ϊ0
    mov DWORD [ebp-8], 1    ; ��i��ʼ��Ϊ1

.L2:
    mov eax, [ebp-8]        ; ��i��ֵ���ص�eax
    cmp eax, 100            ; �Ƚ�i�Ƿ����100
    jg .L4                  ; ���i > 100����ת��.L4

    mov eax, [ebp-4]        ; ��sum�ĵ�ǰֵ���ص�eax
    add eax, [ebp-8]        ; ��i��ֵ�ӵ�eax
    mov [ebp-4], eax        ; ���µ�sumֵ���

    add DWORD [ebp-8], 1    ; ��i����1
    jmp .L2                 ; ����ѭ����ʼ

.L4:
    push DWORD [ebp-4]      ; ��sum��ֵѹջ��Ϊprintf�Ĳ���
    push format             ; ����ʽ�ַ����ĵ�ַѹջ
    call printf             ; ����printf����
    add esp, 8              ; �����ջ��2��������ÿ��4�ֽڣ�

    mov eax, 0              ; ������ֵ0����eax
    leave                   ; �ָ��ɵĻ�ַָ���ջָ��
    ret                     ; ���ص�����

*/