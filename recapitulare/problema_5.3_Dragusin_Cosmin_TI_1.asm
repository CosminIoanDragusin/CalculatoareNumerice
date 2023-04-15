org 100h

.MODEL SMALL                                    ;Declararea modelului de memorie

tabel segment At 00h
    dw 512 dup(?)
tabel ends

.STACK                                          ;Declarare stiva de 1024 octeti
.DATA                                           ;Declarare segment date
    TabInt DB 16 DUP('xx-X '),'$'               ;Initializare linie ecran
    HexSimb DB '0','1','2','3','4','5','6'      ;Tabela simboluri hexa
    DB '7','8','9','A','B','C','D','E','F'
    NumInt DB 0                                 ;Prima intrerupere din linie
    NumIntL DB 0 
    var DW 0                               ;Nr. intr. din coloana curenta
.CODE    
    ASSUME: ES:tabel                              ;Declarare segment cod
    MOV AX,@DATA                                ;Incarcare registru segment date   
    MOV DS,AX
    MOV CX,16 
    MOV SI,0                                  ;Initializare contor linii
Rows:
    PUSH CX ;CX -> stiva
    MOV DI,0 ;Init. index caractere pelinie
    MOV CX,16
    MOV AL,NumInt
    MOV NumIntL,AL
Intrs:
    CMP DX,0A000H               ;Vectorul pointeaza la zona BIOS? 
    
    JA InBios
    MOV TabInt[DI+3],'D'        ;Etichetare zona DOS
    JMP ET
InBios:
    MOV TabInt[DI+3],'B'        ;Etichetare zona BIOS
ET: 
    PUSH DS
    MOV SI,VAR[BX]
    MOV DS,DX
    CMP BYTE PTR DS:[SI],0CFH  ;Prima instructiune este IRET? 
    POP DS
    JNE PresHan                 ;Daca nu, handler prezent
    MOV TabInt[DI+3],'N'        ;Etichetare handler nesetat
PresHan:
    MOV AH,0                    ;AL detine nr.-ul intreruperii
    MOV DL,16
    DIV DL                      ;AX:DL -> AL cât, AH rest
    MOV BX,OFFSET HexSimb
    XLAT                        ;AL <- DS:[BX+AL]
    MOV BYTE PTR TabInt[DI],AL  ;Setare prima cifra hexa a int.
    MOV AL,AH
    XLAT
    MOV BYTE PTR TabInt[DI+1],AL ;Setare a 2-a cifra a int.
    ADD DI,5
    ADD NumIntL,16
    LOOP Intrs
    POP CX
    MOV AH,09H
    MOV DX,OFFSET TabInt
    INT 21H                     ;Afisarea unei linii ecran
    INC NumInt
    LOOP Rows                   ;Procesarea urmat. linii ecran
    MOV AX,4C00H
    INT 21H
END

ret




