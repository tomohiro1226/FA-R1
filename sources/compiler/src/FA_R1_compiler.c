#include "./FA_R1_header.h"
#include "./FileWrite/FileWrite.h"
#include "./FileWrite/wkDataBase/wkDataBase.h"
#include "./mapping/label/label_mapping.h"
#include "./mapping/ram/ram_mapping.h"
#include "./opcode_EN/opCodeEncoder.h"
//#include "./opcode_EN/format/format.h"
//#include "./Reg_EN/Registers_encode.h"

#define IN_FILENAME argv[1]
// #define DEBUG

int Replacement_LabelInfo(int *output_data, LabelMap_List *Lp);

int main(int argc, char const *argv[]) {

    FILE *fp;
    int  output_data[max_RomSize] = {0};    //Storage area of output data
    char buf[max_line] = "";                // One line buffer
    char opcode[max_line] = "";             // Operation code
    char label_num[max_label_len] = "";     // Label number

    int  ir[2] = {0};               // Intermediate representation
    int  input_line_cnt = 0;        // Input line counter
    int  output_line_cnt = 0;       // Output line counter
    int  err_cnt = 0;               // Error counter
    int  ret = 0;

    RamMap_List *Rp = NULL;
    Rp = add_RamMap("\0", 0);

    LabelMap_List *Lp = NULL;
    Lp = add_LabelMap("\0", 0); //先頭ノード

    /*wkDatabase Initialization*/
    wkDataBase_init();

    /*insert HLT (バグ対策)*/
    output_data[max_RomSize-1] = (HLT << 11);

    /*open source.asm*/
    fp = fopen(IN_FILENAME, "r" ); //コマンドプロンプト上から引数
    if (fp == NULL){
        printf( "Couldn't open %s \n" ,IN_FILENAME);
        return ERROR_RETURN;
    }

    printf( "Opening %s\n\n" , IN_FILENAME);

    /*open xx.asm start*/
    while (fgets(buf, max_line, fp) != NULL) {
        /*Replace "\n" with "\0"*/
        strtok(buf, "\n");  //old strtok(buf, "\n\0"); ??
        /*get opcode*/
        if( sscanf(buf, "%s" , opcode) == 1){
            /*devide operation by opcode*/
            if (opcode[0] == ':' ){
               /*: (Label number) line then*/
               if (sscanf(buf, ":%s" , label_num) == 1){
                    /*Assign the current number of output side lines*/
                    LabelMap(Lp, label_num, output_line_cnt);//ラベルをラベルマップに追加
                            //ﾗﾍﾞﾙ構造体ポインタ、ラベル名、現在の行数番号

               }else{
                    /*Error operation*/
                    printf( "%d : %s\ncouldn't analyze.\n\n" , input_line_cnt + 1, buf);
                    err_cnt++;
               }
           }else if (opcode[0] == '-'){
           }else if (opcode[0] == '\n'){
           }else{

                ret = call_opcode(opcode, buf, ir, Rp, Lp); //bufに格納されたデータをバイナリに変換
                                //opコード、opデータ、データ格納配列、ﾗﾑ構造体ポインタ、ﾗﾍﾞﾙ構造体ポインタ

                if( ret == ERROR_RETURN){
                    /* Error operation */
                    printf( "%d : %s\ncouldn't analyze.\n\n" , input_line_cnt + 1, buf);
                    err_cnt++;
                }

                if( ret == 1 ){

                    add_wkDataBase(buf);//bufデータを格納(mifデータdebug時に便利だから)

                    output_data[output_line_cnt] = ir[0];//バイナリデータを配列に格納

                    output_line_cnt++;
                }

                if( ret == 2 ){

                    add_wkDataBase(buf);
                    add_wkDataBase(buf);

                    output_data[output_line_cnt] = ir[0];
                    output_line_cnt++;

                    output_data[output_line_cnt] = ir[1];
                    output_line_cnt++;
                }
            }
        }
        input_line_cnt++;
    }
    fclose(fp);

    if( err_cnt != 0 ){
        // Exit if there is an error
        printf( "\nCompilation failed ( %d error )\n" , err_cnt);
        return ERROR_RETURN;
    }

    if( err_cnt == 0 ){
        Replacement_LabelInfo(output_data, Lp); //ラベルの番地を割り当てる(ラベル仮番号→ラベル番号)
        FileWrite(output_data);//.mifファイルに書き込む
        return 0;
    }

    return ERROR_RETURN; //ここに来ることはないと思う
}

int Replacement_LabelInfo(int *output_data, LabelMap_List *Lp){
    int i;
    int tmp;

    // Replacement of label information
    for(i=0; i<max_RomSize; i++){
        if((output_data[i] & 0xF800) == (GOTO << 11)){ // goto
            tmp = request_LabelMap_Value(Lp, ((output_data[i] & 0x7FE) >> 1));
            output_data[i] = (GOTO << 11) | (tmp << 1) | (output_data[i] & 0x01);
        }
        if((output_data[i] & 0xF800) == (CALL << 11)){ // call
            tmp = request_LabelMap_Value(Lp, ((output_data[i] & 0x7FE) >> 1));
            output_data[i] = (CALL << 11) | (tmp << 1) | (output_data[i] & 0x01);
        }
    }

    return 0;
}
