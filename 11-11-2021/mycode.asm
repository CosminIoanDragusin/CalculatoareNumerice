
.model small
.stack
.data
versiune db 'Versiunea sistemulului de operare este:$'
.code

Scriere proc        
     xor cx,cx    
     mov ax,bx  
     mov dx,10    

AddChar:
    div dl        
    add ah,30h    
    push ax        
    inc cx        
    xor ah,ah    
    cmp al,0    
    jne AddChar        
    mov ah, 30h    
Verificare:
    cmp cx,2    
    jnl Afisare 
    push ax       
    inc cx        
    jmp Verificare     
Afisare:
    pop dx
    mov dl,dh
    mov ah,2    
    int 21h
 loop Afisare   

ret
Scriere endp

start:
 mov ax,@data
 mov ds,ax
 mov dx,offset versiune
 mov ah,09h
 int 21h

 mov ah,30h
 int 21h
mov dl,al
 mov dh,ah
 xor bx,bx
 mov bl,dl
 push dx
 call Scriere

 mov dl,2eh
 mov ah,2
 int 21h

 xor bx,bx
 pop dx
 mov bl,dh
 call Scriere
 
 mov ax,4c00h
 int 21h
 end start




