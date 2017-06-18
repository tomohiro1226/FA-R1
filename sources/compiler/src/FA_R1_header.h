#ifndef __HEADER_
#define __HEADER_

/*standard library include*/
#include <stdio.h>
#include <string.h>
#include <time.h>
#include <assert.h>
#include <stdlib.h>

/*constant*/
#define max_RomSize 1024    // Maximum size of ROM
#define max_label_len 31    // Maximum length of label that can be read
#define max_line 1024       // Maximum length of one line in xx.asm

#define ERROR_RETURN -1

/*users library include*/
#include "op_codes.h"

/*macro*/
#define TRUE(x) (x == 'T' || x == '1')
#define FALSE(x) (x == 'F' || x == '0')

#endif
