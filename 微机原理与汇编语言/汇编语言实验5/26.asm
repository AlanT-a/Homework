DATAS SEGMENT  
DATAS ENDS

STACKS SEGMENT
    ;�˴������ջ�δ���
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
    MOV AX,DATAS
    MOV DS,AX
    
    call print
    
    MOV AH,4CH
    INT 21H
print proc
	push ax
	push dx
	;�س���ascii��
	mov dl,13
	mov ah,2
	int 21h
	
	pop dx
	pop ax
	ret
print endp
CODES ENDS
    END START
