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
    
    mov ax,526
    mov bl,10
    
    ;��һ�����̺�������ѹջ
    div bl
    push ax
    mov ah,0
    ;�ڶ������̺�������ѹջ
    div bl
    push ax
    mov ah,0
    ;���������̺�������ѹջ
    div bl
    push ax
    mov ah,0
    ;���δ�ӡÿ����
    pop ax
    mov dl,ah
    add dl,48
    mov ah,2
    int 21h
    
    pop ax
    mov dl,ah
    add dl,48
    mov ah,2
    int 21h
    
    pop ax
    mov dl,ah
    add dl,48
    mov ah,2
    int 21h
    
    MOV AH,4CH
    INT 21H
CODES ENDS
    END START

