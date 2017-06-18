#include "./../ram_mapping.h"

int main(int argc, char const *argv[]) {

    RamMap_List *p = NULL;

    p = add_RamMap("\0",0); //先頭ノード

    printf("Test Start in %s\n",__FILE__);

    /*assert( RamMap(First node address, variable name, program counter value))*/
    assert( RamMap(p, "RAM1", 100) == 100);
    assert( RamMap(p, "RAM2", 200) == 200);
    assert( RamMap(p, "RAM3", 300) == 300);

    assert( RamMap(p, "RAM1", 400) == 100); //"RAM1"の名前で登録しているので、戻り値は"100"
    assert( RamMap(p, "RAM2", 500) == 200);
    assert( RamMap(p, "RAM3", 600) == 300);

    printf("Test Exit\n");
    return 0;
}
