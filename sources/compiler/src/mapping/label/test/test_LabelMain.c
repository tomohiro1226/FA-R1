#include "./../label_mapping.h"

int main(int argc, char const *argv[]) {

    LabelMap_List *p = NULL;

    p = add_LabelMap("\0", 0); //先頭ノード

    printf("Test Start in %s\n",__FILE__);

    /*assert( LabelMap(first node address, label name, program count))*/
    assert( LabelMap(p, "Label1", 100) == 0);
    assert( LabelMap(p, "Label2", 200) == 0);
    assert( LabelMap(p, "Label3", 300) == 0);

    assert( request_LabelMap_NodeNum(p, "Label1") == 1);
    assert( request_LabelMap_NodeNum(p, "Label2") == 2);
    assert( request_LabelMap_NodeNum(p, "Label3") == 3);

    assert( request_LabelMap_Value(p, 1) == 100);
    assert( request_LabelMap_Value(p, 2) == 200);
    assert( request_LabelMap_Value(p, 3) == 300);

    assert( LabelMap(p, "Label1", 400) == 0);
    assert( LabelMap(p, "Label2", 500) == 0);
    assert( LabelMap(p, "Label3", 600) == 0);

    assert( request_LabelMap_NodeNum(p, "Label1") == 1);
    assert( request_LabelMap_NodeNum(p, "Label2") == 2);
    assert( request_LabelMap_NodeNum(p, "Label3") == 3);

    assert( request_LabelMap_Value(p, 1) == 400);
    assert( request_LabelMap_Value(p, 2) == 500);
    assert( request_LabelMap_Value(p, 3) == 600);

    printf("Test Exit\n");
    return 0;
}
