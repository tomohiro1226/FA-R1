--  FA_R1
--  decode.vhd
--  Fukunaga
--  2017.01.17

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity decode is
    port (
        RESET    : in  std_logic;
        CLK_ID   : in  std_logic;
        ROM_DATA : in  std_logic_vector (15 downto 0);
        OP_CODE  : out std_logic_vector ( 4 downto 0);
        OP_DATA  : out std_logic_vector ( 9 downto 0);
        S_FLG    : out std_logic --Source index register flag
    );
end decode;

architecture RTL of decode is

begin
    process(CLK_ID, RESET)
    begin
        if( RESET = '1' ) then
            OP_CODE <= "00000";
            OP_DATA <= "0000000000";
            S_FLG <= '0';
        elsif (CLK_ID'event and CLK_ID = '1') then
            OP_CODE <= ROM_DATA(15 downto 11);
            OP_DATA <= ROM_DATA(10 downto  1);
            S_FLG   <= ROM_DATA(0);
        end if;
    end process;
end RTL;