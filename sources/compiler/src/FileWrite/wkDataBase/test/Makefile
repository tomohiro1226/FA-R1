#Makefile
Test: test_wkDBmain.o wkDataBase.o
		gcc -o Test test_wkDBmain.o wkDataBase.o

test_wkDBmain.o: ./test_wkDBmain.c
		gcc -c ./test_wkDBmain.c

wkDataBase.o: ./../wkDataBase.c
		gcc -c ./../wkDataBase.c

.PHONY: clean
clean:
		rm -rf test_wkDBmain.o wkDataBase.o Test
