DATAS SEGMENT
    ;�˴��������ݶδ���  
DATAS ENDS

STACKS SEGMENT
    ;�˴������ջ�δ���
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
    MOV AX,DATAS
    MOV DS,AX
    
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
    
    ;���
    ;��ʼ��������
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
    
    MOV AH,4CH
    INT 21H
CODES ENDS
    END START



