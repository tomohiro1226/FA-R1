cls
gcc -c test_FWmain.c
gcc -c ./../FileWrite.c
gcc -c ./../wkDataBase/wkDataBase.c
gcc test_FWmain.o FileWrite.o wkDataBase.o