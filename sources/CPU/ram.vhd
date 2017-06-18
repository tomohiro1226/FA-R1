--  FA_R1
--  ram.vhd 
--  Aoki
--  2016.12.17

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
entity ram is

port (
    RESET           :   in  std_logic;
    CLK_MEM         :   in  std_logic;
    CLK_WB          :   in  std_logic;
    RAM_REN         :   in  std_logic;
    RAM_WEN         :   in  std_logic;
    RAM_ADDRESS     :   in  std_logic_vector ( 9 downto 0);
    RAM_W_DATA      :   in  std_logic_vector (15 downto 0);
    REG_W_DATA_R_W  :   out std_logic_vector (15 downto 0);
    REG_W_DATA_E_R  :   in  std_logic_vector (15 downto 0)
    );
end ram;

architecture RTL of ram is
constant RAM_MAX : integer := 1023;
subtype RAMWORD is std_logic_vector(15 downto 0);
type RAMARRAY is array (0 to RAM_MAX) of RAMWORD;
signal RAMDATA : RAMARRAY;
signal ADR_IN : integer range 0 to RAM_MAX;
begin
    ADR_IN <= conv_integer(RAM_ADDRESS);

    process (CLK_WB)
    begin
        if (CLK_WB'event and CLK_WB = '1') then
            if (RAM_WEN = '1') then --Operation after reception
                RAMDATA(ADR_IN) <= RAM_W_DATA;
            end if ;
        end if ;
    end process ;

    process (CLK_MEM, RESET)
    begin
        if( RESET = '1') then
            REG_W_DATA_R_W <= (others=>'0');
        elsif(CLK_MEM'event and CLK_MEM = '1') then
            if ( RAM_REN = '1') then
                REG_W_DATA_R_W <= RAMDATA(ADR_IN); -- from ramdata to reg
            else
                REG_W_DATA_R_W <= REG_W_DATA_E_R; -- to reg
            end if;
        end if;
    end process ;
end RTL;