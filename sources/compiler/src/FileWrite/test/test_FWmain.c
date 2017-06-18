#include "./../FileWrite.h"

int main(int argc, char const *argv[]) {

    int Output_Data[1024]={0};

    printf("Test Start in %s \nCOMPILE TIME = %s\n",__FILE__,__TIME__);

    wkDataBase_init();

    add_wkDataBase("addlw   0x50");
    add_wkDataBase("addwf   W   FR_0");

    Output_Data[0] = 0xFFFF;
    Output_Data[1] = 0xFFF;
    Output_Data[2] = 0xFF;
    Output_Data[3] = 0xF;

    assert(FileWrite(Output_Data) == 0);
    //※test後は生成されたmifファイルを確認すること

    printf("Test Exit\n");

    return 0;
}
