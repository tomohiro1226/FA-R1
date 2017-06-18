cls
gcc -c test_FormatMain.c
gcc -c ./../../../Reg_EN/Registers_encode.c
gcc -c ./../../../mapping/label/label_mapping.c
gcc -c ./../format.c
gcc -c ./../../../mapping/ram/ram_mapping.c
gcc format.o label_mapping.o ram_mapping.o Registers_encode.o test_FormatMain.o