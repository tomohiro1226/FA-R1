#ifndef __OP_CODES
#define __OP_CODES

/* OP Codes list*/
#define NOP      0        //00000
#define ADDLW    1        //00001
#define SUBLW    2        //00010
#define MOVLW    3        //00011
#define LD       4        //00100
#define ST       5        //00101
#define ANDLW    6        //00110
#define IORLW    7        //00111
#define XORLW    8        //01000
#define GOTO     9        //01001
#define CALL    10        //01010
#define BT      11        //01011
#define BF      12        //01100
#define BTFSC   14        //01110
#define BTFSS   13        //01101
#define ADDWF   15        //01111
#define SUBWF   16        //10000
#define MOVF    17        //10001
#define SLL     18        //10010
#define SRL     19        //10011
#define SRA     20        //10100
#define ANDWF   21        //10101
#define IORWF   22        //10110
#define XORWF   23        //10111
#define NOT     24        //11000
#define MOVWF   25        //11001
#define PUSH    26        //10010
#define POP     27        //10011
#define CMP     28        //10100
#define HLT     29        //10101
#define RET     30        //10110

#endif
