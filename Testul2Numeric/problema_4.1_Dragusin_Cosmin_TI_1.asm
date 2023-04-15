;       --problema 4.1
.MODEL SMALL
.STACK
.DATA
 	msg0 db 'Shift (dreapta)',"$"
	msg1 db 'Shift (stanga)',"$"
	msg2 db 'Ctrl',"$"
	msg3 db 'Alt',"$"
	msg4 db 'Scroll Lock',"$"
	msg5 db 'Num Lock',"$"
	msg6 db 'Caps Lock',"$"
	msg7 db 'Insert',"$"
	msgN db 'nicio tasta',"$" 
	
	x0 dw 1
	x1 dw 2
	x2 dw 4
	x3 dw 8
	x4 dw 16
	x5 dw 32
	x6 dw 64
	x7 dw 128
	N  dw 0    
	
.CODE

MOV ax,@DATA
MOV ds,ax    
MOV dx,040h
MOV bx,017h

MOV es,dx
MOV ax,es:[bx]

MOV bx,ax

CMP bx,x0
JE ET0

CMP bx,x1
JE ET1

CMP bx,x2
JE ET2

CMP bx,x3
JE ET3

CMP bx,x4
JE ET4

CMP bx,x5
JE ET5

CMP bx,x6
JE ET6

CMP bx,x7
JE ET7
CMP bx,N
JE ETN  
 
ET0:
       MOV dx,offset msg0
	   JMP afisare 
	   
ET1:
       MOV dx,offset msg1
	   JMP afisare 
	   
ET2:
       MOV dx,offset msg2
	   JMP afisare 

ET3:
       MOV dx,offset msg3
	   JMP afisare 
	   
ET4:
       MOV dx,offset msg4
	   JMP afisare 

ET5:
       MOV dx,offset msg5
	   JMP afisare 	   

ET6:
       MOV dx,offset msg6
	   JMP afisare 
	   
ET7:
       MOV dx,offset msg7
	   JMP afisare   
ETN:
	   MOV dx,offset msgN
	   JMP afisare   
	   
afisare:
		MOV ah,09h
		INT 21h 

MOV ah,4CH
INT 21h

end