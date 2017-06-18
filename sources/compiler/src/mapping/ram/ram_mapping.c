#include "ram_mapping.h"

/*--------------------------------------------
    文字列に対になったデータ番号を見つける
        引数   :   先頭アドレス、任意文字列、任意番号
        戻り値 :   データ番号
--------------------------------------------*/
int RamMap(RamMap_List *firstnode, char *caracter, int number){

RamMap_List *ret_p;
RamMap_List *p;
int ret;

    /*データ探索*/
    ret = search_RamMap(firstnode, caracter);//データが無かったら"-1"

    /*リストにデータがあった*/
    if(ret != ERROR_RETURN){
        return ret; //データの番号を返却
    }

    /*リストにデータが無かった*/
    if(ret == -1){

        /*リストに新規登録*/
        ret_p = add_RamMap(caracter, number);

        /*新規リストアドレスを最終アドレスに追加*/
        for(p=firstnode; p->next!=NULL; p=p->next);//pに最終アドレスを格納
        p->next = ret_p;

        /*新規登録したデータの番号を返却*/
        return ret_p->value;
    }

    return ERROR_RETURN; //エラー(ここに来ることはない)
}

/*--------------------------------------------
    新しいメモリ領域を確保し、データを格納する
        引数   :   任意文字列、任意番号
        戻り値 :   格納されたアドレス
--------------------------------------------*/
RamMap_List* add_RamMap(char *caracter, int number){ //データ追加
    RamMap_List *new_p;

    new_p = (RamMap_List*)malloc(sizeof(RamMap_List) );//メモリ領域を確保
    if( new_p == NULL ){ //領域が確保できなかったら
        printf("メモリアロケートエラー\n");
        exit(EXIT_FAILURE);
    }

    strcpy(new_p->ch, caracter);
    new_p->value  = number;
    new_p->next = NULL;

    return new_p;
}

/*--------------------------------------------
    任意の文字列がリストにあるか探索する
        引数      :   先頭アドレス、任意文字列
        戻り値    :    リストに格納された数字
--------------------------------------------*/
int search_RamMap(RamMap_List *firstnode, char *caracter){
    RamMap_List *p;

    for(p=firstnode; p!=NULL; p=p->next){ // p->nextが NULLまで
        if(!(strcmp(caracter, p->ch))){ //リスト内の文字列を探索
            return p->value;
        }
    }

    return ERROR_RETURN; //データが見つからなった
}
