DATAS SEGMENT
	;���ڴ���û�����
    a1 db 0,0,0,0,0,0,0,0
    tips db "input a number:$"
    confirm db "Your input:$"
    sort_output db "After sorted:$"
    input_tip db "Input datas:$"
      
DATAS ENDS

STACKS SEGMENT
    ;�˴������ջ�δ���
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
	;����˵��
	;������һ��8���ڵ���
	;��������Ժ�ո�ָ���ÿ������һ��100���ڵ���
	;�����n������س�����
	;�ó����շǽ�������
    MOV AX,DATAS
    MOV DS,AX
    ;��ӡ��ʾ
    mov bx,offset tips
    call print_tip
    ;������Ҫ������ٸ���,����cx��
    mov ah,1
    int 21h
    mov cl,al
    mov ch,0
    sub cl,48
    ;��������
    mov dl,10
    mov ah,2
    int 21h
    mov dl,13
    mov ah,2
    int 21h
    mov bx,offset input_tip
    call print_tip
    ;ѭ���������� �Կո���зֿ�
    mov bx,offset a1
    ;��ڲ������ڴ��λ��bx�����������cx
    call input
    
    mov bx,offset confirm
    call print_tip
    
    
    mov bx,offset a1
    call loop_print
    
    
    mov bx,offset sort_output
    call print_tip
    ;���� cx�д������������bx����������ֵ���ʼλ��
    mov bx,offset a1
    call sort
    
    mov bx,offset a1
    call loop_print
    
    MOV AH,4CH
    INT 21H
print_tip proc
	;����һ����ڲ���
	;��������ַ�����ƫ�Ƶ�ַ���׵�ַ��Ϊ��ڲ���
	;�õ�����ڲ����ļĴ���Ϊbx
	push ax
	push bx
	push dx

s:	
	mov al,ds:[bx]
	cmp al,'$'
	je e
	mov dl,al
	mov ah,2
	int 21h
	inc bx
	jmp s
e:	
	mov dl,10
    mov ah,2
    int 21h
    mov dl,13
    mov ah,2
    int 21h
	pop dx
	pop bx
	pop ax
	ret
print_tip endp

input proc
	push ax
	push cx
	push dx
	mov dx,0
inputs:
muladd:
    mov ah,1
    int 21h
    ;�����ո���߻س���Ϊһ������
    cmp al,32
    je next
    cmp al,13
    je next
    sub al,48
    ;�ڴ��������ƶ���al,al�������ݴ浽dl
    mov dl,ds:[bx]
    mov dh,al
    mov al,dl
    ;al*10+dl
    mov dl,10
    mul dl
    add al,dh
    ;al���ݷŻ��ڴ�
    mov ds:[bx],al
    ;���ǿո񣬽��Ŷ�
    jmp muladd
    ;�����ո񣬶���һ����
next:
    inc bx
    loop inputs
    pop dx
    pop cx
    pop ax
	ret
input endp


print_num proc
	push ax
	push cx
	push bx
	push dx
	;������axһ��ֵ
    ;cx��Ϊ������
    mov cx,0
    ;do-whileѭ����ÿһλ
s:  mov bl,10
    div bl
    push ax
    inc cx
    cmp al,0
    je n
    mov ah,0
    jmp s
    ;���
n:  pop ax
	mov dl,ah
	add dl,48
	mov ah,2
	int 21h
	loop n
	pop dx
	pop bx
	pop cx
	pop ax
	ret
print_num endp

loop_print proc
	;ѭ����ӡ�ڴ��е�����
	;��ڲ���Ϊbx�����ڴ��ƫ�Ƶ�ַ
	;�޳��ڲ���
	push ax
	push dx
	push cx
	push dx
    cal:
    mov ah,0
    mov al,ds:[bx]
    ;���������ax��������ԴΪ�ڴ�
    call print_num
    mov dl,32
    mov ah,2
    int 21h
    inc bx
    loop cal
    mov dl,10
    mov ah,2
    int 21h
    mov dl,13
    mov ah,2
    int 21h
    
    pop dx
    pop cx
    pop bx
    pop ax
	ret
loop_print endp

sort proc
	push ax
	push bx
	push cx
	push dx
	push si
	push di
	;ax bx���ڴ��ڴ������ݵ�ַ���Ƚ�
	;di�洢�����׵�ַ
	mov di,bx
	;dx��n-1��ð�ݵĵڶ���ѭ���Ƚ�n-1-i��ֵ
	mov dx,cx
	sub dx,1
sort_loop:
	;si��Ϊ�����������ڴ洢i��ֵ
	mov si,0
begins:
	;ȡ�����������Ƚ�
	mov ah,ds:[bx]
	inc bx
	mov al,ds:[bx]
	cmp ah,al
	jns replace
	inc si
	cmp dx,si
	jna hh
	jmp begins
replace:
	;�ڴ��е�ֵ���л���
	mov ds:[bx],ah
	sub bx,1
	mov ds:[bx],al
	inc bx
	inc si
	cmp dx,si
	jna hh
	jmp begins
hh:	
	mov bx,di
	loop sort_loop
	
	pop di
	pop si
	pop dx
	pop cx
	pop bx
	pop ax
	ret
sort endp
CODES ENDS
    END START

