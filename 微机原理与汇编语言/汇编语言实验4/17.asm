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
    
    mov ax,666
    call print_ax
    
    ;����Ժ�����Ҫ���ε��õĻ���һЩ�Ĵ����ܵ���Ӱ��
    ;����Ӱ�쵽�����Ĵ�����ֵ ��ý��л�ԭ�ֳ�
    ;�˴���û�漰�������� Ӧ�ò���Ӱ�� ����������ǻ�ԭ��
    mov ax,253
    call print_ax
    
    MOV AH,4CH
    INT 21H
    
    ;�ú�������ڲ���Ϊax���޳��ڲ���
print_ax proc
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
	
	;��ԭ�ֳ�
	pop dx
	pop cx
	pop bx
	ret
print_ax endp
CODES ENDS
    END START


