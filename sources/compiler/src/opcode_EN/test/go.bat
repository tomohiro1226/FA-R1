cls
gcc -c test_opENmain.c
gcc -c ./../../Reg_EN/Registers_encode.c
gcc -c ./../../mapping/label/label_mapping.c
gcc -c ./../format/format.c
gcc -c ./../../mapping/ram/ram_mapping.c
gcc -c ./../opCodeEncoder.c
gcc test_opENmain.o Registers_encode.o label_mapping.o format.o ram_mapping.o opCodeEncoder.o