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
    
    mov ax,26
    mov bl,10
    div bl
    ;���������̴�����
    push ax
    ;��ӡ��λ
    mov dl,al
    add dl,48
    mov ah,2
    int 21h
    ;��ӡ��λ
    pop dx
    mov dl,dh
    add dl,48
    mov ah,2
    int 21h
    
    
    MOV AH,4CH
    INT 21H
CODES ENDS
    END START

