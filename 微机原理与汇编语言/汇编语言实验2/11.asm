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
    ;����������
    mov ah,1
    int 21h
    push ax
    mov ah,1
    int 21h
    push ax
    
    ;���������Ľ��
    pop cx
    mov ch,0
    sub cx,48
    pop ax
    mov ah,0
    sub ax,48
    mov bl,10
    mul bl
    add ax,cx
    
    mov bl,10
    ;��ӡҪ�������ֵ
    div bl
    push ax
    mov dl,al
    add dl,48
    mov ah,2
    int 21h
    
    pop dx
    mov dl,dh
    add dl,48
    mov ah,2
    int 21h
    
    
    MOV AH,4CH
    INT 21H
CODES ENDS
    END START

