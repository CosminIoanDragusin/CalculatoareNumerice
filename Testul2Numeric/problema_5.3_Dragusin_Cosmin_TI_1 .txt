org 100h

; Problema 5.3: Sa se scrie un program in limbaj de asamblare 
; care sa afiseze starea curenta a circuitului 8259A, respectiv 
; continuturile registrelor IMR, ISR, IRR.


.model small
.stack
.data   
    	msg1 db 'IMR:$' 
	msg2 db 0dh,0ah,'IRR:$' 
	msg3 db 0dh,0ah,'ISR:$' 
	hexa db '01'  
.code
afisare proc near
		    push ax
			push bx
			push cx
			push dx
			push si 
					
			mov ah,0
			mov dx,0
			mov cx,8h
			mov bx,2h 
impartire:
			div bx          ; impartim la 2
			push dx         ; in dx avem restul impartitri la 2h
			mov dx,0
			loop impartire
			mov cx,8h
consola_afis:
			pop si
			mov dl,byte ptr hexa[si] ; mutam in dl codul pentru cifra de afisat  
			mov ah,02h
			int 21h                  ; afisam cifra (0 sau 1) pe consola
			loop consola_afis 
 					
			pop si
			pop dx
			pop cx
			pop bx
			pop ax
			ret
afisare endp
start:  
			mov  ax,@data       
			mov  ds,ax         
;citire IMR 
			mov  ah,09h    
			lea  dx,msg1        ; afisam mesajul cu IMR
			int  21h 
			
			mov dx,21h
			in al,dx          
			call afisare

;citire IRR
			mov  ah,09h    
			lea  dx,msg2        ; afisam mesajul cu IRR
			int  21h 
			
			mov dx,20h          ; ocw3 pt. selectie IRR (bit 3 = 0 si RR = 1, RIS = 0)
			mov al,0ah
			out dx,al           ; scriem in portul de iesire 20h valoarea 0ah 
			in al,dx            ; citim de la portul 20h
			call afisare
;citire ISR
			mov  ah,09h    
			lea  dx,msg3        ; afisam mesajul cu ISR
			int  21h 
			
			mov dx,20h
			mov al,0bh
			out dx,al           ; scriem in portul de iesire 20h valoarea 0bh 
			in al,dx            ; citim de la portul 20h
			call afisare			
	
			mov  ah,4Ch       
			int  21h            ; returneaza controlul la sistemul de operare
end start 




