DATAS SEGMENT
    a1 dw 0
DATAS ENDS

STACKS SEGMENT
    ;�˴������ջ�δ���
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
    MOV AX,DATAS
    MOV DS,AX

	call get_num
	;ax�д�ź����ó��Ľ��
	mov bx,offset a1
	mov ds:[bx],ax
	
	
    MOV AH,4CH
    INT 21H
    
get_num proc
	push bx
	push cx
	;һ��ʼ����bx�洢��ǰ�˵õĽ��
    mov bx,0
    
    ;�����ַ�ͬʱ�������
f:	mov ah,1
    int 21h
    cmp al,'a'
    je next
    sub al,48
    mov ah,0
    ;����bx*10+ax ����ڴ浽bx��
    mov cx,ax
    mov ax,bx
    mov bx,10
    mul bx
    add ax,cx
    mov bx,ax
    
    jmp f
next:    
    ;��������ִ���ax��
    mov ax,bx    
    pop cx
    pop bx
	ret
get_num endp
CODES ENDS
    END START


