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
    
    mov ax,-555
    call print
    mov ax,666
    call print
    
    MOV AH,4CH
    INT 21H
print proc
	;��ڲ�����ax���޳��ڲ���
	mov bx,ax
	and bh,10000000B
	cmp bh,0
	je d
	neg ax
	mov dl,'-'
	push ax
	mov ah,2
	int 21h
	pop ax
	d:
	call digit
	ret
print endp
digit proc
	;��ԭ�ֳ�ǰ����Ӱ��ļĴ���ѹջ
    push bx
    push cx
    push dx
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
	mov dl,10
	mov ah,2
	int 21h
	mov dl,13
	mov ah,2
	int 21h
	;��ԭ�ֳ�
	pop dx
	pop cx
	pop bx
	
	ret
digit endp
CODES ENDS
    END START
