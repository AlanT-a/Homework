DATAS SEGMENT
    a1 dw 5
DATAS ENDS

STACKS SEGMENT
    ;�˴������ջ�δ���
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
    MOV AX,DATAS
    MOV DS,AX
    
    mov bx,offset a1
    mov ax,ds:[bx]
    call fun
    
    
    
    MOV AH,4CH
    INT 21H
fun proc
	push bx
	push cx
	push dx
	;���������ax ����Ҫ���ڲ���
    mov cx,ax
p:  sub cx,1
    cmp cx,0
    je s
    mul cx
    jmp p
    
    
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
	pop cx
	pop bx
	ret
fun endp
CODES ENDS
    END START


