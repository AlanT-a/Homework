DATAS SEGMENT
    a1 db "Hello$"
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
    call fun 
    
    
    MOV AH,4CH
    INT 21H
fun proc
	;����һ����ڲ���
	;��������ַ�����ƫ�Ƶ�ַ���׵�ַ��Ϊ��ڲ���
	;�õ�����ڲ����ļĴ���Ϊbx
	push ax
	push bx
	push dx

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
	pop dx
	pop bx
	pop ax
	ret
fun endp
CODES ENDS
    END START



