DATAS SEGMENT
    a1 db 'H','W','C','$'
DATAS ENDS

STACKS SEGMENT
    ;�˴������ջ�δ���
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
    MOV AX,DATAS
    MOV DS,AX
    
    call fun 
    
    
    MOV AH,4CH
    INT 21H
fun proc
	;������ڶ�û��
	push ax
	push bx
	mov bx,offset a1
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
	pop bx
	pop ax
	ret
fun endp
CODES ENDS
    END START


