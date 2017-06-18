#include "opCodeEncoder.h"

/*******************************************************************************
    引数    :   オペコード(上位5ビットの事),
                オペデータ(全ビット16ビットの事),
                バイナリデータを返却用配列(普段は[0]のみ、特殊用途では[1]も使用),
                RAMリスト(リスト構造)の格納アドレス,
                Labelリスト(リスト構造)の格納アドレス
    戻り値  :   正常終了 1, 異常終了 0
********************************************************************************/

int call_opcode(char *opcode, char *op_data, int *b_op_data,
                    RamMap_List *Ram_fn, LabelMap_List *Label_fn){

    int b_ret;

    b_op_data[0] = 0;//初期化
    b_op_data[1] = 0;//初期化

    if( strcmp(opcode, "nop") == 0){
        b_op_data[0] = (NOP << 11);
        return 1;
    }

    if( strcmp(opcode, "addlw") == 0){
        b_ret = formatC(op_data, 1, Ram_fn, Label_fn);
        if(b_ret == ERROR_RETURN)return ERROR_RETURN;

        b_op_data[0] = (ADDLW<<11) | b_ret;
        return 1;
    }

    if ( strcmp(opcode, "sublw" ) == 0 ){
        b_ret = formatC(op_data, 1, Ram_fn, Label_fn);
        if(b_ret == ERROR_RETURN)return ERROR_RETURN;

        b_op_data[0] = (SUBLW<<11) | b_ret;
        return 1;
    }

    if ( strcmp(opcode, "movlw" ) == 0 ){
        b_ret = formatC(op_data, 1, Ram_fn, Label_fn);
        if(b_ret == ERROR_RETURN)return ERROR_RETURN;

        b_op_data[0] = (MOVLW<<11) | b_ret;
        return 1;
    }

    if ( strcmp(opcode, "ld" ) == 0 ){
        b_ret = formatC(op_data, 2, Ram_fn, Label_fn);
        if(b_ret == ERROR_RETURN)return ERROR_RETURN;

        b_op_data[0] = (LD<<11) | b_ret;
        return 1;
    }

    if ( strcmp(opcode, "st" ) == 0 ){
        b_ret = formatC(op_data, 2, Ram_fn, Label_fn);
        if(b_ret == ERROR_RETURN)return ERROR_RETURN;

        b_op_data[0] = (ST<<11) | b_ret;
        return 1;
    }

    if ( strcmp(opcode, "andlw" ) == 0 ){
        b_ret = formatC(op_data, 1, Ram_fn, Label_fn);
        if(b_ret == ERROR_RETURN)return ERROR_RETURN;

        b_op_data[0] = (ANDLW<<11) | b_ret;
        return 1;
    }

    if ( strcmp(opcode, "iorlw" ) == 0 ){
        b_ret = formatC(op_data, 1, Ram_fn, Label_fn);
        if(b_ret == ERROR_RETURN)return ERROR_RETURN;

        b_op_data[0] = (IORLW<<11) | b_ret;
        return 1;
    }

    if ( strcmp(opcode, "xorlw" ) == 0 ){
        b_ret = formatC(op_data, 1, Ram_fn, Label_fn);
        if(b_ret == ERROR_RETURN)return ERROR_RETURN;

        b_op_data[0] = (XORLW<<11) | b_ret;
        return 1;
    }

    if ( strcmp(opcode, "goto" ) == 0 ){
        b_ret = formatC(op_data, 3, Ram_fn, Label_fn);
        if(b_ret == ERROR_RETURN)return ERROR_RETURN;

        b_op_data[0] = (GOTO<<11) | b_ret;
        return 1;
    }

    if ( strcmp(opcode, "call" ) == 0 ){
        b_ret = formatC(op_data, 3, Ram_fn, Label_fn);
        if(b_ret == ERROR_RETURN)return ERROR_RETURN;

        b_op_data[0] = (CALL<<11) | b_ret;
        return 1;
    }

    if ( strcmp(opcode, "bt" ) == 0 ){
        b_ret = formatA(op_data, 2);
        if(b_ret == ERROR_RETURN)return ERROR_RETURN;

        b_op_data[0] = (BT<<11) | b_ret;
        return 1;
    }

    if ( strcmp(opcode, "bf" ) == 0 ){
        b_ret = formatA(op_data, 2);
        if(b_ret == ERROR_RETURN)return ERROR_RETURN;

        b_op_data[0] = (BF<<11) | b_ret;
        return 1;
    }

    if ( strcmp(opcode, "btfsc" ) == 0 ){
        b_op_data[0] = (BTFSC<<11);
        return 1;
    }

    if ( strcmp(opcode, "btfss" ) == 0 ){
        b_op_data[0] = (BTFSS<<11);
        return 1;
    }

    if ( strcmp(opcode, "addwf" ) == 0 ){
        b_ret = formatA(op_data, 1);
        if(b_ret == ERROR_RETURN)return ERROR_RETURN;

        b_op_data[0] = (ADDWF<<11) | b_ret;
        return 1;
    }

    if ( strcmp(opcode, "subwf" ) == 0 ){
        b_ret = formatA(op_data, 1);
        if(b_ret == ERROR_RETURN)return ERROR_RETURN;

        b_op_data[0] = (SUBWF<<11) | b_ret;
        return 1;
    }

    if ( strcmp(opcode, "movf" ) == 0 ){
        b_ret = formatA(op_data, 1);
        if(b_ret == ERROR_RETURN)return ERROR_RETURN;

        b_op_data[0] = (MOVF<<11) | b_ret;
        return 1;
    }

    if ( strcmp(opcode, "sll" ) == 0 ){
        b_ret = formatA(op_data, 1);
        if(b_ret == ERROR_RETURN)return ERROR_RETURN;

        b_op_data[0] = (SLL<<11) | b_ret;
        return 1;
    }

    if ( strcmp(opcode, "srl" ) == 0 ){
        b_ret = formatA(op_data, 1);
        if(b_ret == ERROR_RETURN)return ERROR_RETURN;

        b_op_data[0] = (SRL<<11) | b_ret;
        return 1;
    }

    if ( strcmp(opcode, "sra" ) == 0 ){
        b_ret = formatA(op_data, 1);
        if(b_ret == ERROR_RETURN)return ERROR_RETURN;

        b_op_data[0] = (SRA<<11) | b_ret;
        return 1;
    }

    if ( strcmp(opcode, "andwf" ) == 0 ){
        b_ret = formatA(op_data, 1);
        if(b_ret == ERROR_RETURN)return ERROR_RETURN;

        b_op_data[0] = (ANDWF<<11) | b_ret;
        return 1;
    }

    if ( strcmp(opcode, "iorwf" ) == 0 ){
        b_ret = formatA(op_data, 1);
        if(b_ret == ERROR_RETURN)return ERROR_RETURN;

        b_op_data[0] = (IORWF<<11) | b_ret;
        return 1;
    }

    if ( strcmp(opcode, "xorwf" ) == 0 ){
        b_ret = formatA(op_data, 1);
        if(b_ret == ERROR_RETURN)return ERROR_RETURN;

        b_op_data[0] = (XORWF<<11) | b_ret;
        return 1;
    }

    if ( strcmp(opcode, "not" ) == 0 ){
        b_ret = formatA(op_data, 1);
        if(b_ret == ERROR_RETURN)return ERROR_RETURN;

        b_op_data[0] = (NOT<<11) | b_ret;
        return 1;
    }

    if ( strcmp(opcode, "movwf" ) == 0 ){
        b_ret = formatB(op_data);
        if(b_ret == ERROR_RETURN)return ERROR_RETURN;

        b_op_data[0] = (MOVWF<<11) | b_ret;
        return 1;
    }

    if ( strcmp(opcode, "push" ) == 0 ){
        b_ret = formatB(op_data);
        if(b_ret == ERROR_RETURN)return ERROR_RETURN;

        b_op_data[0] = (PUSH<<11) | b_ret;
        return 1;
    }

    if ( strcmp(opcode, "pop" ) == 0 ){
        b_ret = formatB(op_data);
        if(b_ret == ERROR_RETURN)return ERROR_RETURN;

        b_op_data[0] = (POP<<11) | b_ret;
        return 1;
    }

    if ( strcmp(opcode, "cmp" ) == 0 ){
        b_ret = formatB(op_data);
        if(b_ret == ERROR_RETURN)return ERROR_RETURN;

        b_op_data[0] = (CMP<<11) | b_ret;
        return 1;
    }

    if ( strcmp(opcode, "hlt" ) == 0 ){
        b_op_data[0] = (HLT << 11);
        return 1;
    }

    if ( strcmp(opcode, "ret" ) == 0){
        b_op_data[0] = 0b1101100000000110; //POP SI
        b_op_data[1] = 0b0100100000000001; //GOTO 0 SI
        return 2;
    }

    return ERROR_RETURN;
}
