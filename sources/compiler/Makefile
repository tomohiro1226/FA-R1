#Makefile
FA_R1compiler: FA_R1_compiler.o FileWrite.o wkDataBase.o \
			label_mapping.o ram_mapping.o opCodeEncoder.o \
			format.o Registers_encode.o
		gcc -o FA_R1compiler FA_R1_compiler.o FileWrite.o \
			wkDataBase.o label_mapping.o ram_mapping.o \
			opCodeEncoder.o format.o Registers_encode.o

FA_R1_compiler.o: ./src/FA_R1_compiler.c
		gcc -c ./src/FA_R1_compiler.c

FileWrite.o: ./src/FileWrite/FileWrite.c
		gcc -c ./src/FileWrite/FileWrite.c

wkDataBase.o: ./src/FileWrite/wkDataBase/wkDataBase.c
		gcc -c ./src/FileWrite/wkDataBase/wkDataBase.c

label_mapping.o: ./src/mapping/label/label_mapping.c
		gcc -c ./src/mapping/label/label_mapping.c

ram_mapping.o: ./src/mapping/ram/ram_mapping.c
		gcc -c ./src/mapping/ram/ram_mapping.c

opCodeEncoder.o: ./src/opcode_EN/opCodeEncoder.c
		gcc -c ./src/opcode_EN/opCodeEncoder.c

format.o: ./src/opcode_EN/format/format.c
		gcc -c ./src/opcode_EN/format/format.c

Registers_encode.o: ./src/Reg_EN/Registers_encode.c
		gcc -c ./src/Reg_EN/Registers_encode.c

.PHONY: clean
clean:
		rm -rf FA_R1_compiler.o FileWrite.o wkDataBase.o \
			label_mapping.o ram_mapping.o opCodeEncoder.o \
			format.o Registers_encode.o FA_R1compiler
