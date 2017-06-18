--  FA_R1
--  reg_wb.vhd
--  Fukunaga
--  2017.01.17

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity reg_wb is
    Port(
        RESET       : in  std_logic;
        CLK_WB      : in  std_logic;
        REG_WEN     : in  std_logic;
    --REG_A or REG_B
        REG_ADDRESS : in  std_logic_vector( 4 downto 0); --conect REG_ADDRESS
        REG_W_DATA  : in  std_logic_vector(15 downto 0); --conect REG_W DATA
    --List of register
--operated by execute. PC          : out std_logic_vector(15 downto 0); --0x00 Program counter
--operated by execute. SP          : out std_logic_vector(15 downto 0); --0x01 Stack pointer
        W           : out std_logic_vector(15 downto 0); --0x02 Working register
        SI          : out std_logic_vector(15 downto 0); --0x03 Source index register
        FR_0        : out std_logic_vector(15 downto 0); --0x04 File register 0
        FR_1        : out std_logic_vector(15 downto 0); --0x05 File register 1
        FR_2        : out std_logic_vector(15 downto 0); --0x06 File register 2
        FR_3        : out std_logic_vector(15 downto 0); --0x07 File register 3
        FR_4        : out std_logic_vector(15 downto 0); --0x08 File register 4
        FR_5        : out std_logic_vector(15 downto 0); --0x09 File register 5
        FR_6        : out std_logic_vector(15 downto 0); --0x0A File register 6
        FR_7        : out std_logic_vector(15 downto 0); --0x0B File register 7
        FR_8        : out std_logic_vector(15 downto 0); --0x0C File register 8
        FR_9        : out std_logic_vector(15 downto 0); --0x0D File register 9
        FR_A        : out std_logic_vector(15 downto 0); --0x0E File register A
        FR_B        : out std_logic_vector(15 downto 0); --0x0F File register B
        FR_C        : out std_logic_vector(15 downto 0); --0x10 File register C
        FR_D        : out std_logic_vector(15 downto 0); --0x11 File register D
        FR_E        : out std_logic_vector(15 downto 0); --0x12 File register E
        FR_F        : out std_logic_vector(15 downto 0); --0x13 File register F
--operated by execute.        STATUS      : out std_logic_vector(15 downto 0); --0x14 Status register
        PORTA       : out std_logic_vector(15 downto 0); --0x15 Port A register
        PORTB       : out std_logic_vector(15 downto 0); --0x16 Port B register
--Read only. UART_RX     : out std_logic_vector(15 downto 0); --0x17 UART Receiver
        UART_TX     : out std_logic_vector(15 downto 0)  --0x18 UART Transmitter
        --LED : out std_logic_vector(7 downto 0)
    );
end reg_wb;

architecture RTL of reg_wb is

begin
    process(CLK_WB, RESET)
    begin
        if(RESET = '1') then
            W       <=  (others=>'0');
            SI      <=  (others=>'0');
            FR_0    <=  (others=>'0');
            FR_1    <=  (others=>'0');
            FR_2    <=  (others=>'0');
            FR_3    <=  (others=>'0');
            FR_4    <=  (others=>'0');
            FR_5    <=  (others=>'0');
            FR_6    <=  (others=>'0');
            FR_7    <=  (others=>'0');
            FR_8    <=  (others=>'0');
            FR_9    <=  (others=>'0');
            FR_A    <=  (others=>'0');
            FR_B    <=  (others=>'0');
            FR_C    <=  (others=>'0');
            FR_D    <=  (others=>'0');
            FR_E    <=  (others=>'0');
            FR_F    <=  (others=>'0');
            PORTA   <=  (others=>'0');
            PORTB   <=  (others=>'0');
            UART_TX <=  (others=>'0');

        elsif(CLK_WB'event and CLK_WB = '1') then
            if(REG_WEN = '1') then
                case REG_ADDRESS is
                    --when "00000" => PC      <=    REG_W_DATA;
                    --when "00001" => SP      <=    REG_W_DATA;
                    when "00010" => W       <=  REG_W_DATA;
                    when "00011" => SI      <=  REG_W_DATA;
                    when "00100" => FR_0    <=  REG_W_DATA;
                    when "00101" => FR_1    <=  REG_W_DATA;
                    when "00110" => FR_2    <=  REG_W_DATA;
                    when "00111" => FR_3    <=  REG_W_DATA;
                    when "01000" => FR_4    <=  REG_W_DATA;
                    when "01001" => FR_5    <=  REG_W_DATA;
                    when "01010" => FR_6    <=  REG_W_DATA;
                    when "01011" => FR_7    <=  REG_W_DATA;
                    when "01100" => FR_8    <=  REG_W_DATA;
                    when "01101" => FR_9    <=  REG_W_DATA;
                    when "01110" => FR_A    <=  REG_W_DATA;
                    when "01111" => FR_B    <=  REG_W_DATA;
                    when "10000" => FR_C    <=  REG_W_DATA;
                    when "10001" => FR_D    <=  REG_W_DATA;
                    when "10010" => FR_E    <=  REG_W_DATA;
                    when "10011" => FR_F    <=  REG_W_DATA;
                    --when "10100" => STATUS  <=  REG_W_DATA;
                    when "10101" => PORTA   <=  REG_W_DATA;
                    when "10110" => PORTB   <=  REG_W_DATA;
                    --when "10111" => UART_RX <=    REG_W_DATA;
                    when "11000" => UART_TX <=  REG_W_DATA;
                    --when "11001" => SSR1    <=  REG_W_DATA;
                    when others =>
                end case;
            end if;
        end if;
    end process;
    
end RTL;