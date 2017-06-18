#ifndef __WK_DB
#define __WK_DB

/*
    デバッグを容易にするために、.asmファイルから読み取った
    オペコード、データ情報をそのまま.mifファイルに出力する為のデータ保存場所
*/

#include "./../../FA_R1_header.h"
#include "./wkDataBase.h"

typedef struct src{
    char ch[max_line];
    struct src *next;
}SRC;

int wkDataBase_init(void);
char *output_wkDataBase(void);
int add_wkDataBase(char *character);

#endif
