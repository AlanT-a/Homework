DATAS SEGMENT
DATAS ENDS
STACKS SEGMENT
STACKS ENDS
CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
    MOV AX,DATAS
    MOV DS,AX
    
    MOV AH,00H
    MOV AL,02H
    INT 10H
    ;������ʾ����ʼ�к���ʼ��Ϊ2,3
    mov ah,02H
    mov dh,2
    mov dl,3
    int 10h
    ;������ʾҳ��Ϊ0����ʾһ��*��ɫΪ��ɫ
    MOV AH,09H
    MOV BH,0
    MOV AL,'*'
    MOV BL,04H
    MOV CX,1
    INT 10H
    
    
    MOV AH,4CH
    INT 21H
CODES ENDS
    END START


