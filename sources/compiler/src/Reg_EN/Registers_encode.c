#include "Registers_encode.h"

int register_encode(const char *str){
    enum item_key key;
    if( key_from_item_name(str, &key) ){
        switch(key){
            case PC :
                return 0;
            break;
            case SP :
                return 1;
            break;
            case W :
                return 2;
            break;
            case SI :
                return 3;
            break;
            case FR_0 :
                return 4;
            break;
            case FR_1 :
                return 5;
            break;
            case FR_2 :
                return 6;
            break;
            case FR_3 :
                return 7;
            break;
            case FR_4 :
                return 8;
            break;
            case FR_5 :
                return 9;
            break;
            case FR_6 :
                return 10;
            break;
            case FR_7 :
                return 11;
            break;
            case FR_8 :
                return 12;
            break;
            case FR_9 :
                return 13;
            break;
            case FR_A :
                return 14;
            break;
            case FR_B :
                return 15;
            break;
            case FR_C :
                return 16;
            break;
            case FR_D :
                return 17;
            break;
            case FR_E :
                return 18;
            break;
            case FR_F :
                return 19;
            break;
            case STATUS :
                return 20;
            break;
            case PORTA :
                return 21;
            break;
            case PORTB :
                return 22;
            break;
            case UART_RX :
                return 23;
            break;
            case UART_TX :
                return 24;
            break;
            case SSR1 :
                return 25;
            break;
            default:
            break;
        }
    }
    return ERROR_RETURN;
}

int key_from_item_name(const char *pName, enum item_key *pVal){
    const struct item_record* p = records;
    for (;p < &records[COUNTOF(records)];++p){
        if (strcmp(p->name, pName) == 0){
            *pVal = p->key;
            return 1;
        }
    }
    return 0;
}
