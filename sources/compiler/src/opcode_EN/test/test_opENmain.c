#include"./../opCodeEncoder.h"

int main(int argc, char const *argv[]) {

    RamMap_List *Rp = NULL;
    Rp = add_RamMap("\0", 0);

    LabelMap_List *Lp = NULL;
    Lp = add_LabelMap("\0", 0); //先頭ノード

    int b_data[2];

    printf("Test Start in %s \nCOMPILE TIME = %s\n",__FILE__,__TIME__);

    LabelMap(Lp, "Label1", 100);
    LabelMap(Lp, "Label2", 200);
    LabelMap(Lp, "Label3", 300);
    LabelMap(Lp, "Label4", 400);

    assert(call_opcode("addlw", "addlw   0xA     T", b_data, Rp, Lp) == 1);
    assert(b_data[0] == 0b0000100000010101);

    assert(call_opcode("sublw", "sublw   0xA     1", b_data, Rp, Lp) == 1);
    assert(b_data[0] == 0b0001000000010101);

    assert(call_opcode("movlw", "movlw   0xA     F", b_data, Rp, Lp) == 1);
    assert(b_data[0] == 0b0001100000010100);

    assert(call_opcode("ld",    "ld      RAM1"     , b_data, Rp, Lp) == 1);
    assert(b_data[0] == 0b0010000000000000);

    assert(call_opcode("st",    "st      RAM2"     , b_data, Rp, Lp) == 1);
    assert(b_data[0] == 0b0010100000000010);

    assert(call_opcode("andlw", "andlw   0xA     0", b_data, Rp, Lp) == 1);
    assert(b_data[0] == 0b0011000000010100);

    assert(call_opcode("iorlw", "iorlw   0xA"      , b_data, Rp, Lp) == 1);
    assert(b_data[0] == 0b0011100000010100);

    assert(call_opcode("xorlw", "xorlw   0xA"      , b_data, Rp, Lp) == 1);
    assert(b_data[0] == 0b0100000000010100);

    assert(call_opcode("goto",  "goto    Label1"   , b_data, Rp, Lp) == 1);
    assert(b_data[0] == 0b0100100000000010);

    assert(call_opcode("call",  "call    Label2"   , b_data, Rp, Lp) == 1);
    assert(b_data[0] == 0b0101000000000100);

    assert(call_opcode("bt",    "bt      PC      0x3"   , b_data, Rp, Lp) == 1);
    assert(b_data[0] == 0b0101100000000110);

    assert(call_opcode("bf",    "bf      SP      0x3"   , b_data, Rp, Lp) == 1);
    assert(b_data[0] == 0b0110000001000110);

    assert(call_opcode("btfss",  "btfss", b_data, Rp, Lp) == 1);
    assert(b_data[0] == 0b0110100000000000);

    assert(call_opcode("btfsc",  "btfsc", b_data, Rp, Lp) == 1);
    assert(b_data[0] == 0b0111000000000000);

    assert(call_opcode("addwf",  "addwf   W       FR_C", b_data, Rp, Lp) == 1);
    assert(b_data[0] == 0b0111100010100000);

    assert(call_opcode("subwf",  "subwf   SI      FR_D", b_data, Rp, Lp) == 1);
    assert(b_data[0] == 0b1000000011100010);

    assert(call_opcode("movf",  "movf    FR_0    FR_E", b_data, Rp, Lp) == 1);
    assert(b_data[0] == 0b1000100100100100);

    assert(call_opcode("sll",  "sll     FR_1    FR_F", b_data, Rp, Lp) == 1);
    assert(b_data[0] == 0b1001000101100110);

    assert(call_opcode("srl",  "srl     FR_2    STATUS", b_data, Rp, Lp) == 1);
    assert(b_data[0] == 0b1001100110101000);

    assert(call_opcode("sra",  "sra     FR_3    PORTA", b_data, Rp, Lp) == 1);
    assert(b_data[0] == 0b1010000111101010);

    assert(call_opcode("andwf",  "andwf   FR_4    PORTB", b_data, Rp, Lp) == 1);
    assert(b_data[0] == 0b1010101000101100);

    assert(call_opcode("iorwf",  "iorwf   FR_5    UART_RX", b_data, Rp, Lp) == 1);
    assert(b_data[0] == 0b1011001001101110);

    assert(call_opcode("xorwf",  "xorwf   FR_6    UART_TX", b_data, Rp, Lp) == 1);
    assert(b_data[0] == 0b1011101010110000);

    assert(call_opcode("not",  "not     FR_7    SSR1", b_data, Rp, Lp) == 1);
    assert(b_data[0] == 0b1100001011110010);

    assert(call_opcode("movwf",  "movwf   FR_8", b_data, Rp, Lp) == 1);
    assert(b_data[0] == 0b1100100000011000);

    assert(call_opcode("push",  "push    FR_9", b_data, Rp, Lp) == 1);
    assert(b_data[0] == 0b1101000000011010);

    assert(call_opcode("pop",  "pop     FR_A", b_data, Rp, Lp) == 1);
    assert(b_data[0] == 0b1101100000011100);

    assert(call_opcode("cmp",  "cmp     FR_B", b_data, Rp, Lp) == 1);
    assert(b_data[0] == 0b1110000000011110);

    assert(call_opcode("hlt",   "hlt", b_data, Rp, Lp) == 1);
    assert(b_data[0] == 0b1110100000000000);
    assert(call_opcode("ret",  "ret", b_data, Rp, Lp) == 2);
    assert(b_data[0] == 0b1101100000000110);
    assert(b_data[1] == 0b0100100000000001);

    assert(call_opcode("st",    "st      RAM2"     , b_data, Rp, Lp) == 1); //RAM2の同時参照
    assert(b_data[0] == 0b0010100000000010);

    /*error*/
    assert(call_opcode("mov",    "bf      Label4"   , b_data, Rp, Lp) == -1);//movは定義されていない
    assert(b_data[0] == 0);

    assert(call_opcode("mov",    "bf      Label5"   , b_data, Rp, Lp) == -1);//Label5は定義されていない
    assert(b_data[0] == 0);

    printf("Test Exit\n");
    return 0;
}
