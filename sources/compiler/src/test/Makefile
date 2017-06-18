#Makefile
Test: FA_R1_compiler.o FileWrite.o wkDataBase.o \
			label_mapping.o ram_mapping.o opCodeEncoder.o \
			format.o Registers_encode.o
		gcc -o Test FA_R1_compiler.o FileWrite.o \
			wkDataBase.o label_mapping.o ram_mapping.o \
			opCodeEncoder.o format.o Registers_encode.o

FA_R1_compiler.o: ./../FA_R1_compiler.c
		gcc -c ./../FA_R1_compiler.c

FileWrite.o: ./../FileWrite/FileWrite.c
		gcc -c ./../FileWrite/FileWrite.c

wkDataBase.o: ./../FileWrite/wkDataBase/wkDataBase.c
		gcc -c ./../FileWrite/wkDataBase/wkDataBase.c

label_mapping.o: ./../mapping/label/label_mapping.c
		gcc -c ./../mapping/label/label_mapping.c

ram_mapping.o: ./../mapping/ram/ram_mapping.c
		gcc -c ./../mapping/ram/ram_mapping.c

opCodeEncoder.o: ./../opcode_EN/opCodeEncoder.c
		gcc -c ./../opcode_EN/opCodeEncoder.c

format.o: ./../opcode_EN/format/format.c
		gcc -c ./../opcode_EN/format/format.c

Registers_encode.o: ./../Reg_EN/Registers_encode.c
		gcc -c ./../Reg_EN/Registers_encode.c

.PHONY: clean
clean:
		rm -rf FA_R1_compiler.o FileWrite.o wkDataBase.o \
			label_mapping.o ram_mapping.o opCodeEncoder.o \
			format.o Registers_encode.o Test
