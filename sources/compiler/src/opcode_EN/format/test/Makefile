#Makefile
Test: format.o label_mapping.o ram_mapping.o \
				Registers_encode.o test_FormatMain.o
		gcc -o Test format.o label_mapping.o \
			ram_mapping.o Registers_encode.o test_FormatMain.o

test_FormatMain.o: ./test_FormatMain.c
		gcc -c ./test_FormatMain.c

Registers_encode.o: ./../../../Reg_EN/Registers_encode.c
		gcc -c ./../../../Reg_EN/Registers_encode.c

label_mapping.o: ./../../../mapping/label/label_mapping.c
		gcc -c ./../../../mapping/label/label_mapping.c

ram_mapping.o: ./../../../mapping/ram/ram_mapping.c
		gcc -c ./../../../mapping/ram/ram_mapping.c

format.o: ./../format.c
		gcc -c ./../format.c

.PHONY: clean
clean:
		rm -rf format.o label_mapping.o ram_mapping.o \
			Registers_encode.o test_FormatMain.o Test
