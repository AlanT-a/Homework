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
    ;��ʼ������
    mov ax,1526
    mov cx,4
    mov bl,10
	;��ÿ�ε��̺�����
s:  div bl
	push ax
	mov ah,0  
    loop s
    mov cx,4
	;��ӡ���
h:  pop ax
	mov dl,ah
	add dl,48
	mov ah,2
	int 21h
	loop h
	
    MOV AH,4CH
    INT 21H
CODES ENDS
    END START

