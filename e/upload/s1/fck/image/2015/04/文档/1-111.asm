crlf macro
	mov ah,2
	mov dl,0dh
	int 21h
	mov ah,2
	mov dl,0ah
	int 21h
endm

strin macro str
	mov ah,0ah
	lea dx,str
	int 21h
endm

strout macro str
	mov ah,9
	mov dx, offset str
	int 21h
endm


DATAS SEGMENT
    ;�˴��������ݶδ���  
    str1 db 100 dup('$')
    len  equ $-str1;��ȡstr1�ĳ���
    str2 db 100 dup('$')
    
    m1 db 'str1:','$'
    m2 db 'str2:','$'

    matc db 'match','$'
    nomh db 'no match','$'
DATAS ENDS


STACKS SEGMENT
    ;�˴������ջ�δ���
STACKS ENDS



CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
    MOV AX,DATAS
    MOV DS,AX
    MOV ES,AX
            
    ;�˴��������δ���

    mov cx,len;����ѭ������Ϊstr1�ĳ���

    mov di,offset str1
    mov si,offset str2

	strout m1
	strin str1
	crlf
	
	strout m2
	strin str2
	crlf

           
    repz cmpsb	;��ǰ�ַ���ͬ�����ѭ��
    jz match	;��������� match�����
    jnz nomch	;��������� nomatch�����

match:
	strout matc
	jmp close
	
nomch:
	strout nomh
	jmp close


close:
    MOV AH,4CH
    INT 21H
    
CODES ENDS
    END START



