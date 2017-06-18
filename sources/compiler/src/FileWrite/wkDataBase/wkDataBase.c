#include "wkDataBase.h"

static SRC *src_firstnode;
static SRC *add_current_node_addr;
static SRC *output_current_node_addr;

/*初期化*/
int wkDataBase_init(void){
    SRC *tmp; //ダミーノード

    tmp = (SRC*)malloc(sizeof(SRC));
    if( tmp == NULL ){ //領域が確保できなかったら
        printf("メモリアロケートエラー\n");
        exit(EXIT_FAILURE);
    }

    src_firstnode = tmp; //static変数に代入
    src_firstnode->next = NULL;

    add_current_node_addr = src_firstnode;
    output_current_node_addr = src_firstnode;

    return 0;
}

/*.mifファイルに出力する際に使う*/
char *output_wkDataBase(void){

    char *ret_p;

    if(output_current_node_addr->next != NULL){
        ret_p = output_current_node_addr->ch;
        // printf("CH = %s\n", ret_p); //test
        output_current_node_addr = output_current_node_addr->next;
        return ret_p;
    }

    if(output_current_node_addr->next == NULL){
        return NULL;
    }
}

/*.asmファイルからデータベースにデータを保存*/
int add_wkDataBase(char *character){
    SRC *p;

    strcpy(add_current_node_addr->ch,character);

    p = (SRC*)malloc(sizeof(SRC));
    if( p == NULL ){ //領域が確保できなかったら
        printf("メモリアロケートエラー\n");
        exit(EXIT_FAILURE);
    }

    p->next = NULL;
    add_current_node_addr->next = p;
    add_current_node_addr = p;

    return 0;
}
