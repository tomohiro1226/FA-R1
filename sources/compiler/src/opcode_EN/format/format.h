#ifndef __FORMAT_
#define __FORMAT_

#include "./../../FA_R1_header.h"
#include "./../../Reg_EN/Registers_encode.h"
#include "./../../mapping/label/label_mapping.h"
#include "./../../mapping/ram/ram_mapping.h"

int formatA(char *op_data, unsigned char type);
int formatB(char *op_data);
int formatC(char *op_data, unsigned char type, RamMap_List *Ram_fn, LabelMap_List *Label_fn);
int constant_filter(unsigned char *ch);

#endif
