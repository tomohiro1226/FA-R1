#include "format.h"

/****************************************************
    引数  :   オペコードデータ( opcode, REGA, REGB )
              変換タイプ  =  typename :   REG_A,   REG_B
                            1        :   レジスタ、レジスタ
                            2        :   レジスタ、定数(リテラル)
    戻り値 :     formatにそった値を返却
                エラーなら'-1'
****************************************************/
int formatA(char *op_data, unsigned char type){

    unsigned char tmp_str[256] = "";
    unsigned char reg_a[256] = "";
    unsigned char reg_b[256] = "";
    int REG_A = 0, REG_B = 0;

    if (sscanf(op_data, "%s %s %s" , tmp_str, reg_a, reg_b) != 3) return ERROR_RETURN;

    /* 値を取得できたらタイプごとに変換 */
    switch (type) {
        case 1:
            REG_A = register_encode(reg_a);
            REG_B = register_encode(reg_b);
            break;

        case 2:
            REG_A = register_encode(reg_a);
            REG_B = constant_filter(reg_b);
            break;

        default:
            printf("error%d",__LINE__);
            return ERROR_RETURN;
    }

    if(REG_A == ERROR_RETURN || REG_B == ERROR_RETURN)return ERROR_RETURN; //変換エラー
    else return ((REG_A & 0x1F) << 6) | ((REG_B & 0x1F) << 1);
}

/****************************************************
    引数      ：   オペコードデータ( opcode, REGA )
    戻り値    ：   formatにそった値を返却
                  エラーなら'-1'
****************************************************/
int formatB(char *op_data){

    unsigned char tmp_str[256] = "";
    unsigned char reg[256] = "";
    int REG = 0;

    if (sscanf(op_data, "%s %s" , tmp_str, reg) != 2) return ERROR_RETURN;

    REG = register_encode(reg);

    if(REG == ERROR_RETURN)return ERROR_RETURN; //変換エラー
    else return ((REG & 0x1F) << 1);

}
/********************************************************************
    引数      :     オペコードデータ( opcode, ﾘﾃﾗﾙ(ﾗﾍﾞﾙ,定数), SI可否
                    変換タイプ  =  typename :   REG_A,   REG_B
                                            1        :   定数
                                            2        :   RAMADDRESS
                                            3        :   LABELADDRESS
    戻り値    :     formatにそった値を返却
                    エラーなら'-1'
*********************************************************************/
int formatC(char *op_data, unsigned char type,
                RamMap_List *Ram_fn, LabelMap_List *Label_fn){
                                //fn = firstnode

    unsigned char tmp_str[256] = "";
    unsigned char address[256] = "";
    unsigned char si_flg[256] = "";
    int ADDRESS = 0, SI_FLG = 0;

    static int RamMap_cnt = 0; //ramの番地を決める(0番地目から使用する)

    if (sscanf(op_data, "%s %s %s" , tmp_str, address, si_flg) == 3){
        if(TRUE(*si_flg)) SI_FLG = 1; //si_flgが '1' or 'T' なら...
        else if(FALSE(*si_flg)) SI_FLG = 0; //si_flgが '0' or 'F' なら...
        else if(*(si_flg+0) == '-') SI_FLG = 0; //si_flgが '-'なら... (コメントアウトなので)
        else return ERROR_RETURN;  //それ以外ならerror
    }
    else if (sscanf(op_data, "%s %s" , tmp_str, address) == 2){
        SI_FLG = 0; //si_flgが未記入は si_flgが0と見なすので...
    }
    else{
        printf("conversion error %d",__LINE__);
        return ERROR_RETURN; //変換エラー
    }

    /* 値を取得できたらタイプごとに変換 */
    switch (type) {
        case 1: //address
            ADDRESS = constant_filter(address);
            break;

        case 2: //ram
            ADDRESS = RamMap(Ram_fn, address, RamMap_cnt);
            if(ADDRESS == RamMap_cnt)RamMap_cnt++; //Ramアドレスを増やす
            break;

        case 3: //label
            ADDRESS = request_LabelMap_NodeNum(Label_fn, address);
            break;

        default:
            printf("error%d",__LINE__);
            return ERROR_RETURN;
    }

    if(ADDRESS == ERROR_RETURN)return ERROR_RETURN; //変換エラー
    else return ((ADDRESS & 0x3FF) << 1) | ((SI_FLG & 0x1) << 0);
}

/*
    入力された文字列が２進数、１０進数、１６進数、文字を
    見極め全てint型に変換する

    引数      :       文字列
    戻り値    :       int型の変換データ
                     errorの場合は -1を返却
*/

int constant_filter(unsigned char *ch){

    char *endptr = NULL;
    long ret;


    /*引数 ch　が数値なら...*/

    /*  long strtol(
            const char * restrict nptr  //変換する文字
            char ** restrict endptr     //変換できなかった文字列返却先
            int base                    //基数(2～36)
        )                                                               */

    if(*(ch+0)  == '0'){
        if(*(ch+1) == 'x'){ //0xなら16進数とする
            ret = strtol((ch+2), &endptr, 16);
        }

        else if(*(ch+1) == 'h'){ //0hなら2進数とする
            ret = strtol((ch+2), &endptr, 2);
        }

        else if(*(ch+1) == '\0'){
            return 0; //文字列が'0'だったので
        }
    }

    if(*(ch+0) != '0'){ //10進数データとする
        ret = strtol(ch, &endptr, 10);
    }

    if(ret != 0 && *endptr == '\0'){ //正常変換出来たら...
        return (int)ret;
    }


    /*引数 ch が文字なら*/

    if(*(ch+0) == '\'' && *(ch+2) == '\''){ //'x'なら文字とする
        return (int)*(ch+1);
    }


    return ERROR_RETURN; //変換不可能だった

}
