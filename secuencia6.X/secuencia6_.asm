; PIC16F887 Configuration Bit Settings
; Assembly source line config statements
#include "p16f887.inc"
; CONFIG1
; __config 0x20D5
 __CONFIG _CONFIG1, _FOSC_INTRC_CLKOUT & _WDTE_OFF & _PWRTE_OFF & _MCLRE_OFF & _CP_OFF & _CPD_OFF & _BOREN_OFF & _IESO_OFF & _FCMEN_OFF & _LVP_OFF
; CONFIG2
; __config 0x3FFF
 __CONFIG _CONFIG2, _BOR4V_BOR40V & _WRT_OFF
 
    LIST P=16F887
;variables del retardo
N EQU 0xD0      
cont1 EQU 0x20  
cont2 EQU 0x21

;variables del programa
cont3 EQU 0x22  
var1 EQU 0x23
var2 EQU 0x24

	ORG 0x00
INICIO
	BCF STATUS,RP1 
	BSF STATUS,RP0  
	MOVLW 0x71
	MOVWF OSCCON 
	MOVLW 0x10
	MOVWF TRISA 
	CLRF TRISB 
	BSF STATUS,RP1  
	CLRF ANSEL
	CLRF ANSELH
	BCF STATUS,RP0  
	BCF STATUS,RP1
 
    
SEC1  
   
        MOVLW 0x01
        MOVWF var1 
        MOVLW 0x80
        MOVWF var2
        MOVLW 0x05
        MOVWF cont3
    
SEC2

        MOVF var1,0 
        IORWF var2,0
        MOVWF PORTB
	CALL LOOP
	
	RRF var1 ;izquierda
	RLF var2 ;derecha 
	BSF var1,7
	DECFSZ cont3,1
	GOTO SEC2

  
	MOVLW 0x10
	MOVWF var1
  
	MOVLW 0x08
	MOVWF var2
  
	MOVLW 0x05
	MOVWF cont3
     

  
SEC3
	MOVF var1,0 
	IORWF var2,0
	MOVWF PORTB
	CALL LOOP
	RLF var1 ;izquierda
	RRF var2 ;derecha 
	BSF var2,3
	DECFSZ cont3,1
        GOTO SEC3
        GOTO SEC1
LOOP
	CALL RETARDO
	CALL RETARDO
	CALL RETARDO
	CALL RETARDO
	RETURN

RETARDO
    MOVLW N
    MOVWF cont1
    
REP_1
    MOVLW N
    MOVWF cont2
    
REP_2
    DECFSZ cont2,1
    GOTO REP_2
    DECFSZ cont1,1
    GOTO REP_1
    RETURN
    
 End

