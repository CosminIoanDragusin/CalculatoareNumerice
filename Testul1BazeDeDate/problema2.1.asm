org 100h

.MODEL SMALL                                    

tabel segment At 00h
    dw 512 dup(?)
tabel ends

.STACK                                          
.DATA                                           
    TabInt DB 16 DUP('xx-X '),'$'               
    HexSimb DB '0','1','2','3','4','5','6'      
    DB '7','8','9','A','B','C','D','E','F'
    NumInt DB 0                                 
    NumIntL DB 0 
    var DW 0                               
.CODE    
    ASSUME: ES:tabel                              
    MOV AX,@DATA                                  
    MOV DS,AX
    MOV CX,16 
    MOV SI,0                                  
Rows:
    PUSH CX 
    MOV DI,0 
    MOV CX,16
    MOV AL,NumInt
    MOV NumIntL,AL
Intrs:
    CMP DX,0A000H                
    
    JA InBios
    MOV TabInt[DI+3],'D'        
    JMP ET
InBios:
    MOV TabInt[DI+3],'B'        
ET: 
    PUSH DS
    MOV SI,VAR[BX]
    MOV DS,DX
    CMP BYTE PTR DS:[SI],0CFH  
    POP DS
    JNE PresHan                 
    MOV TabInt[DI+3],'N'        
PresHan:
    MOV AH,0                    
    MOV DL,16
    DIV DL                      
    MOV BX,OFFSET HexSimb
    XLAT                        
    MOV BYTE PTR TabInt[DI],AL  
    MOV AL,AH
    XLAT
    MOV BYTE PTR TabInt[DI+1],AL 
    ADD DI,5
    ADD NumIntL,16
    LOOP Intrs
    POP CX
    MOV AH,09H
    MOV DX,OFFSET TabInt
    INT 21H                     
    INC NumInt
    LOOP Rows                   
    MOV AX,4C00H
    INT 21H
END

ret




