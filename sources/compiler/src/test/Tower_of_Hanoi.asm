--  Tower of Hanoi
--  2016.12.19
--  Fukunaga
----------------------------
--  Label CLK_Dividelaration
----------------------------
:START
:END
:HANOI
:BACK_FROM_DISP02

:DISP01
:LOOP00
:LOOP01
:LOOP02
:LOOP03
:LOOP04
:LOOP05
:LOOP06
:LOOP07
:LOOP08

:DISP02
:LOOP09
:LOOP10
:LOOP11
:LOOP12
:LOOP13
:LOOP14
:LOOP15
:LOOP16
:LOOP17
----------------------------
--  Main routine
----------------------------
:START
    nop

    movlw   3           -- Total number of rings
    movwf   FR_0        -- N

    movlw   65          -- A(dec)
    movwf   FR_1

    movlw   66          -- B(dec)
    movwf   FR_2

    movlw   67          -- C(dec)
    movwf   FR_3

    movlw   0
    st      MSG1

    movlw   0
    st      MSG2

    call    HANOI       -- (3, A, B, C)

    ret
:END
    hlt

----------------------------
--  HANOI routine
----------------------------
:HANOI -- (N,X,Y,Z)
    movf    FR_1 W      -- DISP data store
    st      MSG1        --
    movf    FR_3 W      --
    st      MSG2        --

    movlw   1           -- If N is not 1 then
    cmp     FR_0        -- execute DISP
    btfsc               --
    goto    DISP01      --

    movlw   1           -- N-1
    subwf   FR_0 FR_0   --

    push    FR_2        -- Swap FR_2, FR_3
    movf    FR_3 FR_2   --
    pop     FR_3        --

    call    HANOI       -- (N-1,X,Z,Y)

    movf    FR_1 W      -- DISP data store
    st      MSG1        --
    movf    FR_2 W      --
    st      MSG2        --
    goto    DISP02      -- *Do not need to return.*
:BACK_FROM_DISP02
    push    FR_2        -- rotate registers
    movf    FR_1 FR_2   --
    movf    FR_3 FR_1   --
    pop     FR_3        --

    call    HANOI       -- (N-1,Y,X,Z)

    push    FR_2        -- restore registers
    movf    FR_1 FR_2   --
    pop     FR_1        --

    movlw   1           -- N+1
    addwf   FR_0 FR_0   --

    ret

----------------------------
--  DISP01 routine
----------------------------
:DISP01

    ld      MSG1        -- "MSG1"
    movwf   UART_TX
:LOOP00
    bt      SSR1 6
    btfsc
    goto    LOOP00

    movlw   32          -- " "(dec)
    movwf   UART_TX
:LOOP01
    bt      SSR1 6
    btfsc
    goto    LOOP01
    

    movlw   45          -- "-"(dec)
    movwf   UART_TX
:LOOP02
    bt      SSR1 6
    btfsc
    goto    LOOP02

    movlw   45          -- "-"(dec)
    movwf   UART_TX
:LOOP03
    bt      SSR1 6
    btfsc
    goto    LOOP03
    
    movlw   62          -- ">"(dec)
    movwf   UART_TX
:LOOP04
    bt      SSR1 6
    btfsc
    goto    LOOP04
    
    movlw   32          -- " "(dec)
    movwf   UART_TX
:LOOP05
    bt      SSR1 6
    btfsc
    goto    LOOP05

    ld      MSG2        -- "MSG2"
    movwf   UART_TX
:LOOP06
    bt      SSR1 6
    btfsc
    goto    LOOP06

    movlw   10          -- "LF"(dec)
    movwf   UART_TX
:LOOP07
    bt      SSR1 6
    btfsc
    goto    LOOP07

    movlw   13          -- "CR"(dec)
    movwf   UART_TX
:LOOP08
    bt      SSR1 6
    btfsc
    goto    LOOP08


    ret


----------------------------
--  DISP02 routine
----------------------------
:DISP02

    ld      MSG1        -- "MSG1"
    movwf   UART_TX
:LOOP09
    bt      SSR1 6
    btfsc
    goto    LOOP09

    movlw   32          -- " "(dec)
    movwf   UART_TX
:LOOP10
    bt      SSR1 6
    btfsc
    goto    LOOP10

    movlw   45          -- "-"(dec)
    movwf   UART_TX
:LOOP11
    bt      SSR1 6
    btfsc
    goto    LOOP11

    movlw   45          -- "-"(dec)
    movwf   UART_TX
:LOOP12
    bt      SSR1 6
    btfsc
    goto    LOOP12

    movlw   62          -- ">"(dec)
    movwf   UART_TX
:LOOP13
    bt      SSR1 6
    btfsc
    goto    LOOP13

    movlw   32          -- " "(dec)
    movwf   UART_TX
:LOOP14
    bt      SSR1 6
    btfsc
    goto    LOOP14

    ld      MSG2        -- "MSG2"
    movwf   UART_TX
:LOOP15
    bt      SSR1 6
    btfsc
    goto    LOOP15

    movlw   10          -- "LF"(dec)
    movwf   UART_TX
:LOOP16
    bt      SSR1 6
    btfsc
    goto    LOOP16

    movlw   13          -- "CR"(dec)
    movwf   UART_TX
:LOOP17
    bt      SSR1 6
    btfsc
    goto    LOOP17


    goto    BACK_FROM_DISP02  -- Do not return
