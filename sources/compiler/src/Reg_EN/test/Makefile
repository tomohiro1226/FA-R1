#Makefile
Test: test_EnMain.o Registers_encode.o
		gcc -o Test test_EnMain.o Registers_encode.o

Registers_encode.o: ./../Registers_encode.c
		gcc -c ./../Registers_encode.c

test_EnMain.o: ./test_EnMain.c
		gcc -c ./test_EnMain.c

.PHONY: clean
clean:
		rm -rf Registers_encode.o test_EnMain.o Test

