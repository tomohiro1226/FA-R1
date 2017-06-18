#Makefile
Test: test_FWmain.o FileWrite.o wkDataBase.o
		gcc -o Test test_FWmain.o FileWrite.o wkDataBase.o

test_FWmain.o: ./test_FWmain.c
		gcc -c ./test_FWmain.c

FileWrite.o: ./../FileWrite.c
		gcc -c ./../FileWrite.c

wkDataBase.o: ./../wkDataBase/wkDataBase.c
		gcc -c ./../wkDataBase/wkDataBase.c

.PHONY: clean
clean:
	rm -rf test_FWmain.o FileWrite.o wkDataBase.o Test
