#ifndef __Label_MAPPING
#define __Label_MAPPING

#include "./../../FA_R1_header.h"

/*struct*/
typedef struct LabelMap_list{
    unsigned char ch[31]; // 追加する文字列
    unsigned int value;   // 文字列と対になる値
    unsigned int node_num;// ノードの数
    struct LabelMap_list *next;    // 次のノード
}LabelMap_List;

int LabelMap(LabelMap_List *firstnode, char *caracter, int number);
int request_LabelMap_NodeNum(LabelMap_List *firstnode, char *caracter);
int request_LabelMap_Value(LabelMap_List *firstnode, unsigned int node_number);
LabelMap_List* add_LabelMap(char *caracter, int number);
LabelMap_List* search_LabelMap(LabelMap_List *firstnode, char *caracter);

#endif
