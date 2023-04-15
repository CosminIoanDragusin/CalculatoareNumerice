;Conversie in majuscule a caracterelor introduse de la tastatura.

CODE SEGMENT  
	ASSUME CS:CODE
	Handler:PUSH ES	;salvare registre folosite in
		PUSH AX	;cadrul handler-ului utilizator
		MOV AX,40H 
		MOV ES,AX  ;ES <--- adr. inceput zona date BIOS
		OR BYTE PTR ES:[17H],40H ;fortare bit CapsLock in 1
		POP AX	;restaurare registre
		POP ES
		PUSHF
		DB 9AH	;apel handler original INT 09H
	OldOff	DW 0
	OldSeg	DW 0
		IRET
  Install: MOV AX,3509H	;fct. 35h - obtinere adresa handler
		 INT 21H	;ES <-- segment, BX <-- offset
		 CMP BX,OFFSET Handler	;offsetul pointeaza la handler ?
		 JE Allrdy	;daca da, afisaza mesaj si exit
		 MOV CS:OldOff,BX	;salvare offset handler vechi
		 MOV CS:OldSeg,ES	;salvare segment handler vechi
		 MOV AX,CS	;DS <-- CS ptr. setare handler
		 MOV DS,AX
		 MOV DX,OFFSET Handler
		 MOV AX,2509H	;fct. 25h - setare handler nou
		 INT 21H  
 LEA DX,Install	;calcul parte rezidenta a noului handler
		 ADD DX,15
		 MOV CX,4
		 SHR DX,CL
	 	 ADD DX,16
		 MOV AX,3100H	;instalare parte rezid. si revenire in DOS
		 INT 21H
Allrdy:  PUSH CS	;DS <-- CS
		 POP DS
		 LEA DX,Ld	;DX <-- adresa mesaj
		 MOV AX,0900H	;fct. 09h - tiparire sir
		 INT 21H
		 MOV AH,4CH
		 INT 21H

	Ld DB 'Handler utilizator deja instalat !',10,13,'$'

CODE ENDS
END Install