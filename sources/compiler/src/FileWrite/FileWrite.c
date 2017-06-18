#include "FileWrite.h"

static FILE *o_fp;   // file pointer

int FileWrite(int output_data[max_RomSize]){
    time_t timer;
    struct tm *t_tag;
    char output_tmpstr[16] = "";    // Output template strings
    int i;
    char *ret;

    //Get current time
    time(&timer);
    t_tag = localtime(&timer);

    // open write file
    if(Output_FileOpen() == ERROR_RETURN) return ERROR_RETURN;

    // Output ".mif"
    fprintf(o_fp, "----------------------------------------\n" );
    fprintf(o_fp, "--  FA-R1 Memory Initialization File.\n" );

    // fprintf(o_fp, "--  Source file is [%s]\n", IN_FILENAME);
    fprintf(o_fp, "--  Date : %s\n", __DATE__);
    fprintf(o_fp, "--  Time : %d/%d %d:%d:%d\n",
                    t_tag->tm_mon+1, t_tag->tm_mday, t_tag->tm_hour, t_tag->tm_min, t_tag->tm_sec);
    fprintf(o_fp, "----------------------------------------\n" );
    fprintf(o_fp, "DEPTH = 1024;\nWIDTH = 16;\n" );
    fprintf(o_fp, "ADDRESS_RADIX = HEX;\nDATA_RADIX = BIN;\n" );
    fprintf(o_fp, "CONTENT\n    BEGIN\n");

    for( i = 0; i < max_RomSize; i++ ){
        to_binary(output_data[i], output_tmpstr);
        if( i < 16 ){
            fprintf(o_fp, "    00%X  :  %s;-- " , i, output_tmpstr);
        }else if( i < 256 ){
            fprintf(o_fp, "    0%X  :  %s;-- " , i, output_tmpstr);
        }else{
            fprintf(o_fp, "    %X  :  %s;-- " , i, output_tmpstr);
        }

        //insert source text
        fprintf(o_fp, "%s\n", output_wkDataBase());
    }

    fprintf(o_fp, "END;\n\n");

    // close write file
    Output_FileClose();

}
#if 0
int FileOpen(char *filename){

    IN_FILENAME = filename; //ファイルのstatic関数に代入

    fp = fopen(IN_FILENAME, "r" );
    if (fp == NULL){
        printf( "Couldn't open %s \n" ,IN_FILENAME);
        return -1;
    }

    printf( "Opening %s\n\n" , IN_FILENAME);
    return 0;
}
#endif

int Output_FileOpen(void){
    // open write file
   o_fp = fopen(OUT_FILENAME, "w");
   if(o_fp == NULL){
        printf( "Could not open write file. (%s)\n" , OUT_FILENAME);
        return ERROR_RETURN;
   }
   return 0;
}
int Output_FileClose(void){
    fclose(o_fp);

    printf( "Compilation was successful.\n\n" );
    printf( "Output %s\n" , OUT_FILENAME);
    return 0;
}

// Change 0.1 to a character
int to_binary( int ir, char *str){
    char tmp_str[17];
    int  i;
    tmp_str[16] = '\0';
    for (i = 15; i >= 0; i--){
        if (ir & 1){
            tmp_str[i] = '1' ;
        } else {
            tmp_str[i] = '0' ;
        }
        ir = ir >> 1;
    }
    strcpy(str, tmp_str);
    return 0;
}
