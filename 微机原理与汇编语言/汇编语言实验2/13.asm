DATAS SEGMENT
    ;�˴��������ݶδ���  
DATAS ENDS

STACKS SEGMENT
    ;�˴������ջ�δ���
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
	;������̫��Ļ����㲻����ȷ�Ľ��
	;���ڸöδ��룬ǰ��λ���ܴ���255����������
    MOV AX,DATAS
    MOV DS,AX
    
    mov cx,4
    mov bx,0
    ;����һ��4λ�������
i:  mov ah,1
	int 21h
	;al��ֵ�浽dl��
	mov dl,al
	sub dl,48
	mov dh,0
	;bl��ֵ�浽al��*10
	mov al,bl
	mov ah,10
	mul ah
	mov bx,ax
	add bx,dx
	 
    loop i
    ;��ʼ��  ��Ϊ��ӡ���ǰ��׼��
    mov ax,bx
    mov bl,10
    mov cx,4
    
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
