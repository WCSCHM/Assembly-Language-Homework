.model small
.stack 100h
.data
var_timestr db '00:00:00$'
var_newhandler dw ?,?
var_oldhandler dw ?,?
var_xoffset dw 0
var_yoffset dw 0
var_coltemp1 dw 0
var_coltemp2 dw 0
var_coltemp3 dw 0
var_rowtemp1 dw 0
var_rowtemp2 dw 0
var_rowtemp3 dw 0
var_fgcolor db 14
var_isam db 0

draw_row macro _row,_col1,_col2,_color
    local l1
    mov ah,0Ch
    mov bh,0
    mov al,_color
    mov cx,_col1
    mov dx,_row
l1:
    int 10h
    inc cx
    cmp cx,_col2
    jle l1
endm

draw_column macro _col,_row1,_row2,_color
    local l2
    mov ah,0Ch
    mov bh,0
    mov al,_color
    mov cx,_col
    mov dx,_row1
l2:
    int 10h
    inc dx
    cmp dx,_row2
    jle l2
endm

.code

print0 proc
    mov ax,var_xoffset
    mov var_coltemp1,0
    add var_coltemp1,ax
    mov var_coltemp2,30
    add var_coltemp2,ax
    mov ax,var_yoffset
    mov var_rowtemp1,0
    add var_rowtemp1,ax
    mov var_rowtemp2,20
    add var_rowtemp2,ax
    mov var_rowtemp3,50
    add var_rowtemp3,ax
    draw_row var_rowtemp1,var_coltemp1,var_coltemp2,var_fgcolor
    draw_row var_rowtemp3,var_coltemp1,var_coltemp2,var_fgcolor
    draw_column var_coltemp1,var_rowtemp1,var_rowtemp3,var_fgcolor
    draw_column var_coltemp2,var_rowtemp1,var_rowtemp3,var_fgcolor
    ret
print0 endp

print1 proc
    mov ax,var_xoffset
    mov var_coltemp2,30
    add var_coltemp2,ax
    mov ax,var_yoffset
    mov var_rowtemp1,0
    add var_rowtemp1,ax
    mov var_rowtemp3,50
    add var_rowtemp3,ax
    draw_column var_coltemp2,var_rowtemp1,var_rowtemp3,var_fgcolor
    ret
print1 endp

print2 proc
    mov ax,var_xoffset
    mov var_coltemp1,0
    add var_coltemp1,ax
    mov var_coltemp2,30
    add var_coltemp2,ax
    mov ax,var_yoffset
    mov var_rowtemp1,0
    add var_rowtemp1,ax
    mov var_rowtemp2,20
    add var_rowtemp2,ax
    mov var_rowtemp3,50
    add var_rowtemp3,ax
    draw_row var_rowtemp1,var_coltemp1,var_coltemp2,var_fgcolor
    draw_row var_rowtemp2,var_coltemp1,var_coltemp2,var_fgcolor
    draw_row var_rowtemp3,var_coltemp1,var_coltemp2,var_fgcolor
    draw_column var_coltemp1,var_rowtemp2,var_rowtemp3,var_fgcolor
    draw_column var_coltemp2,var_rowtemp1,var_rowtemp2,var_fgcolor
    ret
print2 endp

print3 proc
    mov ax,var_xoffset
    mov var_coltemp1,0
    add var_coltemp1,ax
    mov var_coltemp2,30
    add var_coltemp2,ax
    mov ax,var_yoffset
    mov var_rowtemp1,0
    add var_rowtemp1,ax
    mov var_rowtemp2,20
    add var_rowtemp2,ax
    mov var_rowtemp3,50
    add var_rowtemp3,ax
    draw_row var_rowtemp1,var_coltemp1,var_coltemp2,var_fgcolor
    draw_row var_rowtemp2,var_coltemp1,var_coltemp2,var_fgcolor
    draw_row var_rowtemp3,var_coltemp1,var_coltemp2,var_fgcolor
    draw_column var_coltemp2,var_rowtemp1,var_rowtemp3,var_fgcolor
    ret
print3 endp

print4 proc
    mov ax,var_xoffset
    mov var_coltemp1,0
    add var_coltemp1,ax
    mov var_coltemp2,30
    add var_coltemp2,ax
    mov ax,var_yoffset
    mov var_rowtemp1,0
    add var_rowtemp1,ax
    mov var_rowtemp2,20
    add var_rowtemp2,ax
    mov var_rowtemp3,50
    add var_rowtemp3,ax
    draw_row var_rowtemp2,var_coltemp1,var_coltemp2,var_fgcolor
    draw_column var_coltemp1,var_rowtemp1,var_rowtemp2,var_fgcolor
    draw_column var_coltemp2,var_rowtemp1,var_rowtemp3,var_fgcolor
    ret
print4 endp

print5 proc
    mov ax,var_xoffset
    mov var_coltemp1,0
    add var_coltemp1,ax
    mov var_coltemp2,30
    add var_coltemp2,ax
    mov ax,var_yoffset
    mov var_rowtemp1,0
    add var_rowtemp1,ax
    mov var_rowtemp2,20
    add var_rowtemp2,ax
    mov var_rowtemp3,50
    add var_rowtemp3,ax
    draw_row var_rowtemp1,var_coltemp1,var_coltemp2,var_fgcolor
    draw_row var_rowtemp2,var_coltemp1,var_coltemp2,var_fgcolor
    draw_row var_rowtemp3,var_coltemp1,var_coltemp2,var_fgcolor
    draw_column var_coltemp1,var_rowtemp1,var_rowtemp2,var_fgcolor
    draw_column var_coltemp2,var_rowtemp2,var_rowtemp3,var_fgcolor
    ret
print5 endp

print6 proc
    mov ax,var_xoffset
    mov var_coltemp1,0
    add var_coltemp1,ax
    mov var_coltemp2,30
    add var_coltemp2,ax
    mov ax,var_yoffset
    mov var_rowtemp1,0
    add var_rowtemp1,ax
    mov var_rowtemp2,20
    add var_rowtemp2,ax
    mov var_rowtemp3,50
    add var_rowtemp3,ax
    draw_row var_rowtemp1,var_coltemp1,var_coltemp2,var_fgcolor
    draw_row var_rowtemp2,var_coltemp1,var_coltemp2,var_fgcolor
    draw_row var_rowtemp3,var_coltemp1,var_coltemp2,var_fgcolor
    draw_column var_coltemp1,var_rowtemp1,var_rowtemp3,var_fgcolor
    draw_column var_coltemp2,var_rowtemp2,var_rowtemp3,var_fgcolor
    ret
print6 endp

print7 proc
    mov ax,var_xoffset
    mov var_coltemp1,0
    add var_coltemp1,ax
    mov var_coltemp2,30
    add var_coltemp2,ax
    mov ax,var_yoffset
    mov var_rowtemp1,0
    add var_rowtemp1,ax
    mov var_rowtemp2,20
    add var_rowtemp2,ax
    mov var_rowtemp3,50
    add var_rowtemp3,ax
    draw_row var_rowtemp1,var_coltemp1,var_coltemp2,var_fgcolor
    draw_column var_coltemp2,var_rowtemp1,var_rowtemp3,var_fgcolor
    ret
print7 endp

print8 proc
    mov ax,var_xoffset
    mov var_coltemp1,0
    add var_coltemp1,ax
    mov var_coltemp2,30
    add var_coltemp2,ax
    mov ax,var_yoffset
    mov var_rowtemp1,0
    add var_rowtemp1,ax
    mov var_rowtemp2,20
    add var_rowtemp2,ax
    mov var_rowtemp3,50
    add var_rowtemp3,ax
    draw_row var_rowtemp1,var_coltemp1,var_coltemp2,var_fgcolor
    draw_row var_rowtemp2,var_coltemp1,var_coltemp2,var_fgcolor
    draw_row var_rowtemp3,var_coltemp1,var_coltemp2,var_fgcolor
    draw_column var_coltemp1,var_rowtemp1,var_rowtemp3,var_fgcolor
    draw_column var_coltemp2,var_rowtemp1,var_rowtemp3,var_fgcolor
    ret
print8 endp

print9 proc
    mov ax,var_xoffset
    mov var_coltemp1,0
    add var_coltemp1,ax
    mov var_coltemp2,30
    add var_coltemp2,ax
    mov ax,var_yoffset
    mov var_rowtemp1,0
    add var_rowtemp1,ax
    mov var_rowtemp2,20
    add var_rowtemp2,ax
    mov var_rowtemp3,50
    add var_rowtemp3,ax
    draw_row var_rowtemp1,var_coltemp1,var_coltemp2,var_fgcolor
    draw_row var_rowtemp2,var_coltemp1,var_coltemp2,var_fgcolor
    draw_row var_rowtemp3,var_coltemp1,var_coltemp2,var_fgcolor
    draw_column var_coltemp1,var_rowtemp1,var_rowtemp2,var_fgcolor
    draw_column var_coltemp2,var_rowtemp1,var_rowtemp3,var_fgcolor
    ret
print9 endp

print_colon proc
    mov ax,var_xoffset
    mov var_coltemp1,8
    add var_coltemp1,ax
    mov var_coltemp2,12
    add var_coltemp2,ax
    mov ax,var_yoffset
    mov var_rowtemp1,16
    add var_rowtemp1,ax
    mov var_rowtemp2,20
    add var_rowtemp2,ax
    draw_row var_rowtemp1,var_coltemp1,var_coltemp2,var_fgcolor
    draw_row var_rowtemp2,var_coltemp1,var_coltemp2,var_fgcolor
    draw_column var_coltemp1,var_rowtemp1,var_rowtemp2,var_fgcolor
    draw_column var_coltemp2,var_rowtemp1,var_rowtemp2,var_fgcolor

    mov ax,var_xoffset
    mov var_coltemp1,8
    add var_coltemp1,ax
    mov var_coltemp2,12
    add var_coltemp2,ax
    mov ax,var_yoffset
    mov var_rowtemp1,30
    add var_rowtemp1,ax
    mov var_rowtemp2,34
    add var_rowtemp2,ax
    draw_row var_rowtemp1,var_coltemp1,var_coltemp2,var_fgcolor
    draw_row var_rowtemp2,var_coltemp1,var_coltemp2,var_fgcolor
    draw_column var_coltemp1,var_rowtemp1,var_rowtemp2,var_fgcolor
    draw_column var_coltemp2,var_rowtemp1,var_rowtemp2,var_fgcolor
    ret
print_colon endp

print_black proc
    mov ax,var_xoffset
    mov var_coltemp1,0
    add var_coltemp1,ax
    mov var_coltemp2,30
    add var_coltemp2,ax
    mov ax,var_yoffset
    mov var_rowtemp1,0
    add var_rowtemp1,ax
    mov var_rowtemp2,20
    add var_rowtemp2,ax
    mov var_rowtemp3,50
    add var_rowtemp3,ax
    draw_row var_rowtemp1,var_coltemp1,var_coltemp2,4
    draw_row var_rowtemp2,var_coltemp1,var_coltemp2,4
    draw_row var_rowtemp3,var_coltemp1,var_coltemp2,4
    draw_column var_coltemp1,var_rowtemp1,var_rowtemp3,4
    draw_column var_coltemp2,var_rowtemp1,var_rowtemp3,4
    ret
print_black endp

printA proc
    mov ax,var_xoffset
    mov var_coltemp1,0
    add var_coltemp1,ax
    mov var_coltemp2,10
    add var_coltemp2,ax
    mov ax,var_yoffset
    mov var_rowtemp1,0
    add var_rowtemp1,ax
    mov var_rowtemp2,7
    add var_rowtemp2,ax
    mov var_rowtemp3,20
    add var_rowtemp3,ax
    draw_row var_rowtemp1,var_coltemp1,var_coltemp2,var_fgcolor
    draw_row var_rowtemp2,var_coltemp1,var_coltemp2,var_fgcolor
    draw_column var_coltemp1,var_rowtemp1,var_rowtemp3,var_fgcolor
    draw_column var_coltemp2,var_rowtemp1,var_rowtemp3,var_fgcolor
    ret
printA endp

printP proc
    mov ax,var_xoffset
    mov var_coltemp1,0
    add var_coltemp1,ax
    mov var_coltemp2,10
    add var_coltemp2,ax
    mov ax,var_yoffset
    mov var_rowtemp1,0
    add var_rowtemp1,ax
    mov var_rowtemp2,7
    add var_rowtemp2,ax
    mov var_rowtemp3,20
    add var_rowtemp3,ax
    draw_row var_rowtemp1,var_coltemp1,var_coltemp2,var_fgcolor
    draw_row var_rowtemp2,var_coltemp1,var_coltemp2,var_fgcolor
    draw_column var_coltemp1,var_rowtemp1,var_rowtemp3,var_fgcolor
    draw_column var_coltemp2,var_rowtemp1,var_rowtemp2,var_fgcolor
    ret
printP endp

printM proc
    mov ax,var_xoffset
    mov var_coltemp1,0
    add var_coltemp1,ax
    mov var_coltemp2,10
    add var_coltemp2,ax
    mov var_coltemp3,20
    add var_coltemp3,ax
    mov ax,var_yoffset
    mov var_rowtemp1,0
    add var_rowtemp1,ax
    mov var_rowtemp3,20
    add var_rowtemp3,ax
    draw_row var_rowtemp1,var_coltemp1,var_coltemp3,var_fgcolor
    draw_column var_coltemp1,var_rowtemp1,var_rowtemp3,var_fgcolor
    draw_column var_coltemp2,var_rowtemp1,var_rowtemp3,var_fgcolor
    draw_column var_coltemp3,var_rowtemp1,var_rowtemp3,var_fgcolor
    ret
printM endp

convert proc
    xor ah,ah
    mov dl,10
    div dl
    or ax,3030h
    ret
convert endp

get_time proc
    mov ah,2Ch
    int 21h

    mov var_isam,1
    mov al,ch
    cmp al,11
    jng skip_pm_check
    cmp al,24
    jnl skip_pm_check
    mov var_isam,0
skip_pm_check:
    cmp al,12
    jg hr_over_12
    jmp hr_check_12
hr_over_12:
    sub al,12
hr_check_12:
    cmp al,0
    jne hr_convert_done
    mov al,12
hr_convert_done:
    lea bx,var_timestr
    call convert
    mov [bx],ax

    mov al,cl
    call convert
    mov [bx+3],ax

    mov al,dh
    call convert
    mov [bx+6],ax
    ret
get_time endp

time_int proc
    push ds
    mov ax,@data
    mov ds,ax

    lea bx,var_timestr
    call get_time
    
    mov var_yoffset,65
    mov var_xoffset,30
    call print_black
    mov al,'0'
    cmp [bx],al
    jne h11
    call print0
    jmp h1d
h11: inc al
    cmp [bx],al
    jne h12
    call print1
    jmp h1d
h12: inc al
    cmp [bx],al
    jne h13
    call print2
    jmp h1d
h13: inc al
    cmp [bx],al
    jne h14
    call print3
    jmp h1d
h14: inc al
    cmp [bx],al
    jne h15
    call print4
    jmp h1d
h15: inc al
    cmp [bx],al
    jne h16
    call print5
    jmp h1d
h16: inc al
    cmp [bx],al
    jne h17
    call print6
    jmp h1d
h17: inc al
    cmp [bx],al
    jne h18
    call print7
    jmp h1d
h18: inc al
    cmp [bx],al
    jne h19
    call print8
    jmp h1d
h19:
    call print9
h1d:
    mov var_yoffset,65
    mov var_xoffset,70
    call print_black
    mov al,'0'
    cmp [bx+1],al
    jne h21
    call print0
    jmp h2d
h21: inc al
    cmp [bx+1],al
    jne h22
    call print1
    jmp h2d
h22: inc al
    cmp [bx+1],al
    jne h23
    call print2
    jmp h2d
h23: inc al
    cmp [bx+1],al
    jne h24
    call print3
    jmp h2d
h24: inc al
    cmp [bx+1],al
    jne h25
    call print4
    jmp h2d
h25: inc al
    cmp [bx+1],al
    jne h26
    call print5
    jmp h2d
h26: inc al
    cmp [bx+1],al
    jne h27
    call print6
    jmp h2d
h27: inc al
    cmp [bx+1],al
    jne h28
    call print7
    jmp h2d
h28: inc al
    cmp [bx+1],al
    jne h29
    call print8
    jmp h2d
h29:
    call print9
h2d:
    mov var_yoffset,65
    mov var_xoffset,100
    call print_colon
    mov var_yoffset,65
    mov var_xoffset,120
    call print_black
    mov al,'0'
    cmp [bx+3],al
    jne m11
    call print0
    jmp m1d
m11: inc al
    cmp [bx+3],al
    jne m12
    call print1
    jmp m1d
m12: inc al
    cmp [bx+3],al
    jne m13
    call print2
    jmp m1d
m13: inc al
    cmp [bx+3],al
    jne m14
    call print3
    jmp m1d
m14: inc al
    cmp [bx+3],al
    jne m15
    call print4
    jmp m1d
m15: inc al
    cmp [bx+3],al
    jne m16
    call print5
    jmp m1d
m16: inc al
    cmp [bx+3],al
    jne m17
    call print6
    jmp m1d
m17: inc al
    cmp [bx+3],al
    jne m18
    call print7
    jmp m1d
m18: inc al
    cmp [bx+3],al
    jne m19
    call print8
    jmp m1d
m19:
    call print9
m1d:
    mov var_yoffset,65
    mov var_xoffset,160
    call print_black
    mov al,'0'
    cmp [bx+4],al
    jne m21
    call print0
    jmp m2d
m21: inc al
    cmp [bx+4],al
    jne m22
    call print1
    jmp m2d
m22: inc al
    cmp [bx+4],al
    jne m23
    call print2
    jmp m2d
m23: inc al
    cmp [bx+4],al
    jne m24
    call print3
    jmp m2d
m24: inc al
    cmp [bx+4],al
    jne m25
    call print4
    jmp m2d
m25: inc al
    cmp [bx+4],al
    jne m26
    call print5
    jmp m2d
m26: inc al
    cmp [bx+4],al
    jne m27
    call print6
    jmp m2d
m27: inc al
    cmp [bx+4],al
    jne m28
    call print7
    jmp m2d
m28: inc al
    cmp [bx+4],al
    jne m29
    call print8
    jmp m2d
m29:
    call print9
m2d:
    mov var_yoffset,65
    mov var_xoffset,190
    call print_colon
    mov var_yoffset,65
    mov var_xoffset,210
    call print_black
    mov al,'0'
    cmp [bx+6],al
    jne s11
    call print0
    jmp s1d
s11: inc al
    cmp [bx+6],al
    jne s12
    call print1
    jmp s1d
s12: inc al
    cmp [bx+6],al
    jne s13
    call print2
    jmp s1d
s13: inc al
    cmp [bx+6],al
    jne s14
    call print3
    jmp s1d
s14: inc al
    cmp [bx+6],al
    jne s15
    call print4
    jmp s1d
s15: inc al
    cmp [bx+6],al
    jne s16
    call print5
    jmp s1d
s16: inc al
    cmp [bx+6],al
    jne s17
    call print6
    jmp s1d
s17: inc al
    cmp [bx+6],al
    jne s18
    call print7
    jmp s1d
s18: inc al
    cmp [bx+6],al
    jne s19
    call print8
    jmp s1d
s19:
    call print9
s1d:
    mov var_yoffset,65
    mov var_xoffset,250
    call print_black
    mov al,'0'
    cmp [bx+7],al
    jne s21
    call print0
    jmp s2d
s21: inc al
    cmp [bx+7],al
    jne s22
    call print1
    jmp s2d
s22: inc al
    cmp [bx+7],al
    jne s23
    call print2
    jmp s2d
s23: inc al
    cmp [bx+7],al
    jne s24
    call print3
    jmp s2d
s24: inc al
    cmp [bx+7],al
    jne s25
    call print4
    jmp s2d
s25: inc al
    cmp [bx+7],al
    jne s26
    call print5
    jmp s2d
s26: inc al
    cmp [bx+7],al
    jne s27
    call print6
    jmp s2d
s27: inc al
    cmp [bx+7],al
    jne s28
    call print7
    jmp s2d
s28: inc al
    cmp [bx+7],al
    jne s29
    call print8
    jmp s2d
s29:
    call print9
s2d:
    mov var_yoffset,125
    mov var_xoffset,245
    cmp var_isam,1
    jne print_pm
    mov var_fgcolor,4
    call printP
    mov var_fgcolor,14
    call printA
    jmp after_ampm
print_pm:
    mov var_fgcolor,4
    call printA
    mov var_fgcolor,14
    call printP
after_ampm:
    mov var_yoffset,125
    mov var_xoffset,260
    call printM

    pop ds
    iret
time_int endp

setup_int proc
    mov ah,35h
    int 21h
    mov [di],bx
    mov [di+2],es

    mov dx,[si]
    push ds
    mov ds,[si+2]
    mov ah,25h
    int 21h
    pop ds
    ret
setup_int endp

main proc
    mov ax,@data
    mov ds,ax

    mov ah,0
    mov al,13h
    int 10h

    mov ah,0Ch
    mov bh,0
    mov al,4
    xor dx,dx
    xor cx,cx
fill_screen:
    int 10h
    inc cx
    cmp cx,320
    jne skip_inc_row
    inc dx
    cmp dx,200
    je done_fill
    xor cx,cx
skip_inc_row:
    jmp fill_screen
done_fill:
    mov var_fgcolor,14
    
    mov var_xoffset,5       
    mov var_yoffset,140     
    call print2

    mov var_xoffset,45      
    mov var_yoffset,140
    call print0

    mov var_xoffset,85
    mov var_yoffset,140
    call print2

    mov var_xoffset,125
    mov var_yoffset,140
    call print4


    mov var_newhandler,offset time_int
    mov var_newhandler+2,seg time_int
    lea di,var_oldhandler
    lea si,var_newhandler
    mov al,1Ch
    call setup_int

    mov ah,0
    int 16h

    lea di,var_newhandler
    lea si,var_oldhandler
    mov al,1Ch
    call setup_int

    mov ah,0
    mov al,3
    int 10h

    mov ah,4Ch
    int 21h
main endp

end main
