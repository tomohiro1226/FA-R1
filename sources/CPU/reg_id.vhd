--  FA_R1
--  STEP 1
--  reg_id.vhd
--  Fukunaga
--  2017.01.17

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity reg_id is
    port (
        RESET       : in  std_logic;
        CLK_ID      : in  std_logic;
    --REG_A or REG_B
        No_REG_read : in  std_logic_vector( 4 downto 0); --conect ROM_DATA(x downto y)
        REG_R_DATA  : out std_logic_vector(15 downto 0); --conect REG_A,REG_B
    --List of register
--operated by execute. --PC          : in  std_logic_vector(15 downto 0); --0x00 Program counter
--operated by execute. --SP          : in  std_logic_vector(15 downto 0); --0x01 Stack pointer
        W           : in  std_logic_vector(15 downto 0); --0x02 Working register
        SI          : in  std_logic_vector(15 downto 0); --0x03 Source index register
        FR_0        : in  std_logic_vector(15 downto 0); --0x04 File register 0
        FR_1        : in  std_logic_vector(15 downto 0); --0x05 File register 1
        FR_2        : in  std_logic_vector(15 downto 0); --0x06 File register 2
        FR_3        : in  std_logic_vector(15 downto 0); --0x07 File register 3
        FR_4        : in  std_logic_vector(15 downto 0); --0x08 File register 4
        FR_5        : in  std_logic_vector(15 downto 0); --0x09 File register 5
        FR_6        : in  std_logic_vector(15 downto 0); --0x0A File register 6
        FR_7        : in  std_logic_vector(15 downto 0); --0x0B File register 7
        FR_8        : in  std_logic_vector(15 downto 0); --0x0C File register 8
        FR_9        : in  std_logic_vector(15 downto 0); --0x0D File register 9
        FR_A        : in  std_logic_vector(15 downto 0); --0x0E File register A
        FR_B        : in  std_logic_vector(15 downto 0); --0x0F File register B
        FR_C        : in  std_logic_vector(15 downto 0); --0x10 File register C
        FR_D        : in  std_logic_vector(15 downto 0); --0x11 File register D
        FR_E        : in  std_logic_vector(15 downto 0); --0x12 File register E
        FR_F        : in  std_logic_vector(15 downto 0); --0x13 File register F
        STATUS      : in  std_logic_vector(15 downto 0); --0x14 Status register
        PORTA       : in  std_logic_vector(15 downto 0); --0x15 Port A register
        PORTB       : in  std_logic_vector(15 downto 0); --0x16 Port B register
        UART_RX     : in  std_logic_vector(15 downto 0); --0x17 UART Receiver
        UART_TX     : in  std_logic_vector(15 downto 0); --0x18 UART Transmitter
        SSR1        : in  std_logic_vector(15 downto 0)  --0x19 Serial status register
    );
end reg_id;
architecture RTL of reg_id is
begin
    process(CLK_ID, RESET)
    begin
        if(RESET = '1') then
            REG_R_DATA <=  (others=>'0');
        elsif( CLK_ID'event and CLK_ID = '1') then
            case No_REG_read is
                --when "00000" => REG_R_DATA <= PC;
                --when "00001" => REG_R_DATA <= SP;
                when "00010" => REG_R_DATA <= W;
                when "00011" => REG_R_DATA <= SI;
                when "00100" => REG_R_DATA <= FR_0;
                when "00101" => REG_R_DATA <= FR_1;
                when "00110" => REG_R_DATA <= FR_2;
                when "00111" => REG_R_DATA <= FR_3;
                when "01000" => REG_R_DATA <= FR_4;
                when "01001" => REG_R_DATA <= FR_5;
                when "01010" => REG_R_DATA <= FR_6;
                when "01011" => REG_R_DATA <= FR_7;
                when "01100" => REG_R_DATA <= FR_8;
                when "01101" => REG_R_DATA <= FR_9;
                when "01110" => REG_R_DATA <= FR_A;
                when "01111" => REG_R_DATA <= FR_B;
                when "10000" => REG_R_DATA <= FR_C;
                when "10001" => REG_R_DATA <= FR_D;
                when "10010" => REG_R_DATA <= FR_E;
                when "10011" => REG_R_DATA <= FR_F;
                when "10100" => REG_R_DATA <= STATUS;
                when "10101" => REG_R_DATA <= PORTA;
                when "10110" => REG_R_DATA <= PORTB;
                when "10111" => REG_R_DATA <= UART_RX;
                when "11000" => REG_R_DATA <= UART_TX;
                when "11001" => REG_R_DATA <= SSR1;
                when others =>
            end case;
        end if;
    end process;
end RTL;