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
    ;����axһ����
    mov ax,65
    mov cx,16
s:
    mov bx,ax
    push ax
    and bx,8000H
    cmp bx,0
    je f
    mov dl,49
    jmp p
f:
    mov dl,48
p:
    mov ah,2
    int 21h
    pop ax
    rol ax,1
    loop s
    
    MOV AH,4CH
    INT 21H
CODES ENDS
    END START

