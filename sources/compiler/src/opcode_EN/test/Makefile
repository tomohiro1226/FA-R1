#Makefile
Test: test_opENmain.o Registers_encode.o label_mapping.o \
			format.o ram_mapping.o opCodeEncoder.o
		gcc -o Test test_opENmain.o Registers_encode.o \
			label_mapping.o format.o ram_mapping.o opCodeEncoder.o

test_opENmain.o: ./test_opENmain.c
		gcc -c ./test_opENmain.c

Registers_encode.o: ./../../Reg_EN/Registers_encode.c
		gcc -c ./../../Reg_EN/Registers_encode.c

format.o: ./../format/format.c
		gcc -c ./../format/format.c

label_mapping.o: ./../../mapping/label/label_mapping.c
		gcc -c ./../../mapping/label/label_mapping.c

ram_mapping.o: ./../../mapping/ram/ram_mapping.c
		gcc -c ./../../mapping/ram/ram_mapping.c

opCodeEncoder.o: ./../opCodeEncoder.c
		gcc -c ./../opCodeEncoder.c

.PHONY: clean
clean:
		rm -rf test_opENmain.o Registers_encode.o label_mapping.o \
			format.o ram_mapping.o opCodeEncoder.o Test
