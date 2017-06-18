#ifndef __RAM_MAPPING
#define __RAM_MAPPING

#include "./../../FA_R1_header.h"

/*struct*/
typedef struct RamMap_list{
    unsigned char ch[31]; // 追加する文字列
    unsigned int value;     // 文字列と対になる値
    struct RamMap_list *next;    // 次のノード
}RamMap_List;

int RamMap(RamMap_List *firstnode, char *caracter, int number);
RamMap_List* add_RamMap(char *caracter, int number);
int search_RamMap(RamMap_List *firstnode, char *caracter);

#endif
