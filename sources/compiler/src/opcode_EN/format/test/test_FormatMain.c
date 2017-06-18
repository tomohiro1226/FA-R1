#include "./../format.h"

int main(int argc, char const *argv[]) {

    RamMap_List *Rp = NULL;
    Rp = add_RamMap("\0", 0);

    LabelMap_List *Lp = NULL;
    Lp = add_LabelMap("\0", 0); //先頭ノード

    printf("Test Start in %s \nTIME = %s\n",__FILE__,__TIME__);

    /*constant_filter*/
    assert(constant_filter("0") == 0);

    assert(constant_filter("0xA") == 10);
    assert(constant_filter("0xb") == 11);

    assert(constant_filter("10") == 10);
    assert(constant_filter("99") == 99);

    assert(constant_filter("0h11") == 3);
    assert(constant_filter("0h101") == 5);

    assert(constant_filter("\'a\'") == 97);
    assert(constant_filter("\'Z\'") == 90);

    /*formatA*/
    assert(formatA("btfsc   PC      0x3",       2) == 0b0000000000000110);
    assert(formatA("btfss   SP      0x3",       2) == 0b0000000001000110);
    assert(formatA("addwf   W       FR_C",      1) == 0b0000000010100000);
    assert(formatA("subwf   SI      FR_D",      1) == 0b0000000011100010);
    assert(formatA("movf    FR_0    FR_E",      1) == 0b0000000100100100);
    assert(formatA("sll     FR_1    FR_F",      1) == 0b0000000101100110);
    assert(formatA("srl     FR_2    STATUS",    1) == 0b0000000110101000);
    assert(formatA("sra     FR_3    PORTA",     1) == 0b0000000111101010);
    assert(formatA("andwf   FR_4    PORTB",     1) == 0b0000001000101100);
    assert(formatA("iorwf   FR_5    UART_RX",   1) == 0b0000001001101110);
    assert(formatA("xorwf   FR_6    UART_TX",   1) == 0b0000001010110000);
    assert(formatA("not     FR_7    SSR1",      1) == 0b0000001011110010);
    assert(formatA("btfsc   PO      0x3",       2) == -1); //POって何！？error
    assert(formatA("addwf   W       FR_Q",      1) == -1); //FR_Qって何！？error

    assert(formatB("movwf   FR_8") == 0b0000000000011000);
    assert(formatB("push    FR_9") == 0b0000000000011010);
    assert(formatB("pop     FR_A") == 0b0000000000011100);
    assert(formatB("cmp     FR_B") == 0b0000000000011110);
    assert(formatB("movwf   FR_G") == -1);

    LabelMap(Lp, "Label1", 100);
    LabelMap(Lp, "Label2", 200);
    LabelMap(Lp, "Label3", 300);
    LabelMap(Lp, "Label4", 400);

    assert(formatC("addlw   0xA     T", 1, Rp, Lp) == 0b0000000000010101);
    assert(formatC("sublw   0xA     1", 1, Rp, Lp) == 0b0000000000010101);
    assert(formatC("movlw   0xA     F", 1, Rp, Lp) == 0b0000000000010100);
    assert(formatC("ld      RAM1"     , 2, Rp, Lp) == 0b0000000000000000);
    assert(formatC("st      RAM2"     , 2, Rp, Lp) == 0b0000000000000010);
    assert(formatC("ld      RAM1"     , 2, Rp, Lp) == 0b0000000000000000);
    assert(formatC("st      RAM2"     , 2, Rp, Lp) == 0b0000000000000010);
    assert(formatC("andlw   0xA     0", 1, Rp, Lp) == 0b0000000000010100);
    assert(formatC("iorlw   0xA"      , 1, Rp, Lp) == 0b0000000000010100);
    assert(formatC("xorlw   0xA"      , 1, Rp, Lp) == 0b0000000000010100);
    assert(formatC("goto    Label1"   , 3, Rp, Lp) == 0b0000000000000010);
    assert(formatC("call    Label2"   , 3, Rp, Lp) == 0b0000000000000100);
    assert(formatC("bt      Label3"   , 3, Rp, Lp) == 0b0000000000000110);
    assert(formatC("bf      Label4"   , 3, Rp, Lp) == 0b0000000000001000);

    assert(formatC("bf      Label4  -比較している"   , 3, Rp, Lp) == 0b0000000000001000);
    assert(formatC("bf      Label4-"   , 3, Rp, Lp) == -1); //Label4の後に'-'が書いてる

    printf("Test Exit\n");
    return 0;
}
