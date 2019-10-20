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
    ;此处输入数据段代码  
    str1 db 100 dup('$')
    len  equ $-str1;获取str1的长度
    str2 db 100 dup('$')
    
    m1 db 'str1:','$'
    m2 db 'str2:','$'

    matc db 'match','$'
    nomh db 'no match','$'
DATAS ENDS


STACKS SEGMENT
    ;此处输入堆栈段代码
STACKS ENDS



CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
    MOV AX,DATAS
    MOV DS,AX
    MOV ES,AX
            
    ;此处输入代码段代码

    mov cx,len;设置循环次数为str1的长度

    mov di,offset str1
    mov si,offset str2

	strout m1
	strin str1
	crlf
	
	strout m2
	strin str2
	crlf

           
    repz cmpsb	;当前字符相同则继续循环
    jz match	;相等这跳到 match代码段
    jnz nomch	;不相等跳到 nomatch代码段

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



