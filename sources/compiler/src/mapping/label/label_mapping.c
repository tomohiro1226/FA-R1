#include "label_mapping.h"

/*--------------------------------------------
    文字列に対になったデータ番号を見つける
        引数   :   先頭アドレス、任意文字列、任意番号
        戻り値 :   データ番号
--------------------------------------------*/
int LabelMap(LabelMap_List *firstnode, char *caracter, int number){

LabelMap_List *ret_p;
LabelMap_List *p;
int ret,i;

    /*データ探索*/
    ret_p = search_LabelMap(firstnode, caracter);//データが無かったらNULL

    /*リストにデータがあった*/
    if(ret_p != NULL){
        /*データを更新*/
        ret_p->value = number;

        return 0;
    }

    /*リストにデータが無かった*/
    if(ret_p == NULL){

        /*リストに新規登録*/
        ret_p = add_LabelMap(caracter, number);

        /*新規リストアドレスを最終アドレスに追加*/
        for(p=firstnode,i=1; p->next!=NULL; p=p->next,i++);//pに最終アドレスを格納
        ret_p->node_num = i;
        p->next = ret_p;

        /*新規登録したノード番号を返却*/
        return 0;
    }

    return ERROR_RETURN; //エラー(ここに来ることはない)
}

/*--------------------------------------------
    新しいメモリ領域を確保し、データを格納する
        引数   :   任意文字列、任意番号
        戻り値 :   格納されたアドレス
--------------------------------------------*/
LabelMap_List* add_LabelMap(char *caracter, int number){ //データ追加
    LabelMap_List *new_p;

    new_p = (LabelMap_List*)malloc(sizeof(LabelMap_List) );//メモリ領域を確保
    if( new_p == NULL ){ //領域が確保できなかったら
        printf("メモリアロケートエラー\n");
        exit(EXIT_FAILURE);
    }

    strcpy(new_p->ch, caracter);
    new_p->value  = number;
    new_p->node_num = 0; //初期値
    new_p->next = NULL;

    return new_p;
}

/*--------------------------------------------
任意の文字列がリストにあるか探索する
引数      ：    先頭アドレス、任意文字列
戻り値    ：  　データあり = リスト番号
データなし = NULL
--------------------------------------------*/
LabelMap_List* search_LabelMap(LabelMap_List *firstnode, char *caracter){
    LabelMap_List *p;

    for(p=firstnode; p!=NULL; p=p->next){ // p->nextが NULLまで
        if(!(strcmp(caracter, p->ch))){ //リスト内の文字列を探索
            return p;
        }
    }

    return NULL; //データが見つからなった
}

/*--------------------------------------------
    任意の文字列がリストにあるか探索する
        引数      :   先頭アドレス、任意文字列
        戻り値    :    リストに格納されたノード番号
--------------------------------------------*/
int request_LabelMap_NodeNum(LabelMap_List *firstnode, char *caracter){
    LabelMap_List *p;

    for(p=firstnode; p!=NULL; p=p->next){ // p->nextが NULLまで
        if(!(strcmp(caracter, p->ch))){ //リスト内の文字列を探索
            return p->node_num;
        }
    }

    return ERROR_RETURN; //データが見つからなった
}

/*--------------------------------------------
    任意のノード番号がリストにあるか探索する
        引数      :   先頭アドレス、ノード番号
        戻り値    :    リストに格納された文字列
--------------------------------------------*/
int request_LabelMap_Value(LabelMap_List *firstnode, unsigned int node_number){
    LabelMap_List *p;

    for(p=firstnode; p!=NULL; p=p->next){
        if( p->node_num == node_number){ //リスト内のノード番号と一緒なら
            return p->value;
        }
    }
    return ERROR_RETURN; //データが見つからなかった
}
