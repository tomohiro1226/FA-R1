:start
:stop
:call
    nop
    addlw   0x50 -コメント
    sublw   'B'
    movlw   'a'
    ld      RAM1
    st      RAM2
    
    -飛ばす
    goto    start
    -復帰
    
    andlw   5
    iorlw   0x3
    xorlw   'c'
    goto    stop
    call    call
    
    -修正必要あり
    bt      W   0x3
    bf      SP  0x2
    btfss
    btfsc

    addwf   PC  SI
    subwf   FR_E    FR_F
    movf    UART_RX UART_TX

:stop
    sll     FR_0    FR_1
    srl     FR_2    FR_3
    sra     FR_4    FR_5
    andwf   FR_6    FR_7
    iorwf   FR_8    FR_9
    xorwf   FR_A    FR_B
    not     FR_C    FR_D
:call
    movwf   FR_E
    push    STATUS
    pop     PORTA
    cmp     PORTB

    ret

    hlt
