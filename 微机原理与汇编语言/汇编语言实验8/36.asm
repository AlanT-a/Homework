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
    ;��ӡ���
    mov al,9
    out 70h,al
    in al,71h
    call Date
    mov dl,'-'
    mov ah,2
    int 21h
    ;��ӡ�·�
    mov al,8
    out 70h,al
    in al,71h
    call Date
    mov dl,'-'
    mov ah,2
    int 21h
    ;��ӡ����
    mov al,7
    out 70h,al
    in al,71h
    call Date
    
    MOV AH,4CH
    INT 21H
    ;ע��ʱ����8421BCD��
Date proc
	;��ӡ���ڣ���ڲ�����AL
	push bx
	push cx
	;��ӡ����λ
	mov bl,al
	and al,11110000B
	mov cl,4
	shr al,cl
	mov ah,0
	call print
	;��ӡ����λ
	mov al,bl
	and al,00001111B
	mov ah,0
	call print
	pop cx
	pop bx
	ret
Date endp
print proc
	;����޷���ʮ����������ڲ���ΪAX
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
	
	;��ԭ�ֳ�
	pop dx
	pop cx
	pop bx
	ret
print endp
CODES ENDS
    END START

