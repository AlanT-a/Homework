DATAS SEGMENT
    ;�˴��������ݶδ���  
DATAS ENDS

STACKS SEGMENT
    ;�˴������ջ�δ���
STACKS ENDS



STACKS SEGMENT
    ;�˴������ջ�δ���
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
    MOV AX,DATAS
    MOV DS,AX
    ;����
    mov ah,1
    int 21h
    push ax
    mov ah,1
    int 21h
    push ax
    mov ah,1
    int 21h
    push ax
    
    mov bx,0
    ;�����λ
    pop cx
    sub cx,48
	mov ch,0
    add bx,cx
    ;����ʮλ
    pop cx
    sub cx,48
    mov ch,0
    mov ax,cx
    mov dx,10
    mul dl
    add bx,ax

    ;�����λ
	pop cx
	sub cx,48
    mov ch,0
    mov ax,cx
    mov dx,100
    mul dl
    add bx,ax
    
    mov ax,bx
    
    ;��ӡҪ�������ֵ
    mov cx,3
    mov bl,10
s:  div bl
	push ax
	mov ah,0  
    loop s
    mov cx,3
h:  pop ax
	mov dl,ah
	add dl,48
	mov ah,2
	int 21h
	loop h
    MOV AH,4CH
    INT 21H
    
    
    MOV AH,4CH
    INT 21H
CODES ENDS
    END START



