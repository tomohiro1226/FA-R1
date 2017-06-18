#include "./../wkDataBase.h"

int main(int argc, char const *argv[]) {

    int ret;

    printf("Test Start in %s \nCOMPILE TIME = %s\n",__FILE__,__TIME__);

    wkDataBase_init();

    add_wkDataBase("addlw   0x50");
    add_wkDataBase("addwf   W   FR_0");

    assert( strcmp(output_wkDataBase(), "addlw   0x50") == 0);
    assert( strcmp(output_wkDataBase(), "addwf   W   FR_0") == 0);
    assert( output_wkDataBase() == NULL);

    printf("Test Exit\n");

    return 0;
}
