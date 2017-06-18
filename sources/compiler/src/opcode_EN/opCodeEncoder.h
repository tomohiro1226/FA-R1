#ifndef __OPCODE_EN
#define __OPCODE_EN

#include "./../FA_R1_header.h"
#include "./format/format.h"

int call_opcode(char *opcode, char *op_data, int *b_op_data,
                    RamMap_List *Ram_fn, LabelMap_List *Label_fn);

#endif
