cls
gcc -c ./../mapping/label/label_mapping.c
gcc -c ./../mapping/ram/ram_mapping.c
gcc -c ./../FA_R1_compiler.c
gcc -c ./../FileWrite/FileWrite.c
gcc -c ./../FileWrite/wkDataBase/wkDataBase.c
gcc -c ./../opcode_EN/opCodeEncoder.c
gcc -c ./../opcode_EN/format/format.c
gcc -c ./../Reg_EN/Registers_encode.c

gcc FA_R1_compiler.o FileWrite.o wkDataBase.o label_mapping.o ram_mapping.o opCodeEncoder.o format.o Registers_encode.o
