; PIC16F887 Configuration Bit Settings

; Assembly source line config statements

   
#include "p16f887.inc"

; CONFIG1
; __config 0x28D5
 __CONFIG _CONFIG1, _FOSC_INTRC_CLKOUT & _WDTE_OFF & _PWRTE_OFF & _MCLRE_OFF & _CP_OFF & _CPD_OFF & _BOREN_OFF & _IESO_OFF & _FCMEN_ON & _LVP_OFF
; CONFIG2
; __config 0x3FFF
 __CONFIG _CONFIG2, _BOR4V_BOR40V & _WRT_OFF

    LIST p=16F887
    
;variables del retardo
N EQU 0xD0
cont1 EQU 0x20 
cont2 EQU 0x21

;variables que usa el programa
var1 EQU 0x22
var2 EQU 0x23
contador1 EQU 0x24



    ORG 0x00
    
	BSF STATUS, RP0  ;BANK 1
	MOVLW 0x71
	MOVWF OSCCON ;FREC. DE OSCILACIÓN
	CLRF TRISB   ;TRISB = 0 (SALIDA)
    
	BSF STATUS,RP1   ;BANK 3
	CLRF ANSELH      ;PUERTO B DIGITAL
    
	BCF STATUS,RP0   ;BANK0
	BCF STATUS,RP1
	
	
REINICIO
	;variables
	MOVLW 0x06
	MOVWF var1
	MOVLW 0xC0
	MOVWF var2
	
	;contadores
	MOVLW .6
	MOVWF contador1
	
	
	
INICIO 
	MOVF  var1,0  
	IORWF   var2,0 
	MOVWF   PORTB
	CALL LOOP
	DECFSZ contador1,1
	GOTO SEC1
	GOTO SEC2
	
SEC1	
	BCF STATUS,C
	RRF var2,1 ;
	BCF STATUS,C
	RLF var1,1 ;
	GOTO INICIO

SEC2	
	MOVLW 0x03 
	MOVWF   PORTB
	CALL LOOP
	GOTO REINICIO


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
LOOP
	CALL RETARDO
	CALL RETARDO
	CALL RETARDO
	CALL RETARDO
	RETURN
    end


