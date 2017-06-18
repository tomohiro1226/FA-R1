#ifndef __REG_ENCODE
#define __REG_ENCODE

#include "./../FA_R1_header.h"

/*register list include*/
enum item_key {
#define DEFINE_ID(s, id) id,
#include "Registers.txt"
#undef DEFINE_ID
};
static const struct item_record {
    const char* name;
    enum item_key key;
}
records[] = {
    #define DEFINE_ID(s, id) {s, id},
    #include "Registers.txt"
    #undef DEFINE_ID
};
#define COUNTOF(x) (sizeof (x) / sizeof *(x))

int register_encode(const char *str);
int key_from_item_name(const char *pName, enum item_key *pVal);


#endif
