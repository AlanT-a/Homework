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
    mov ax,3633H
    call print
    MOV AH,4CH
    INT 21H
print proc
	push dx
	mov dl,ah
	;��ڲ�����ax
	push ax
	mov ah,2
	int 21h
	pop ax
	mov dl,al
	mov ah,2
	int 21h
	pop dx
	ret
print endp
CODES ENDS
    END START
