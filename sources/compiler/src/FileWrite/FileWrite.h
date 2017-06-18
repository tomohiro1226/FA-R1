#ifndef __FILE_WRITE
#define __FILE_WRITE

#include "./../FA_R1_header.h"
#include "./wkDataBase/wkDataBase.h"

#define OUT_FILENAME "./ROM_init.mif"
//static char *IN_FILENAME;

int FileWrite(int output_data[max_RomSize]);
int Output_FileOpen(void);
int Output_FileClose(void);
int to_binary( int ir, char *str);


#endif
