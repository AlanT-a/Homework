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
    
    mov ax,4e58H
    call print_hex
    
    MOV AH,4CH
    INT 21H
print_hex proc
	;��ڲ�����ax,�޳��ڲ���
	push bx
	push cx
	push dx
	mov cx,4
	s:
	mov bx,ax
	push ax
	and bh,11110000B
	;���ʵ�ֲ����� �ò���rlr bh,4
	ror bh,1
	ror bh,1
	ror bh,1
	ror bh,1
	cmp bh,9
	ja hex
	mov dl,bh
	add dl,48
	
	jmp over
	hex:
	mov dl,bh
	add dl,87
	
over:
	mov ah,2
	int 21h
	pop ax
	rol ax,1
	rol ax,1
	rol ax,1
	rol ax,1
	loop s
	pop dx
	pop cx
	pop bx
	ret
print_hex endp
CODES ENDS
    END START
