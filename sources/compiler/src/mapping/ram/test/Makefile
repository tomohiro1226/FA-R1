#Makefile
Test: ram_mapping.o test_RamMain.o
		gcc -o Test ram_mapping.o test_RamMain.o

ram_mapping.o: ./../ram_mapping.c
		gcc -c ./../ram_mapping.c

test_RamMain.o: ./test_RamMain.c
		gcc -c ./test_RamMain.c

.PHONY: clean
clean:
		rm -rf ram_mapping.o test_RamMain.o Test
