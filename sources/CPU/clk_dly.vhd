--  FA_R1
--  clk_dly.vhd
--  Fukunaga
--  2017.01.17

library IEEE;
use IEEE.std_logic_1164.all;
entity clk_dly is
    port (
        CLK  : in  std_logic;
        Din  : in  std_logic; --Delay in
        QOUT : out std_logic  --Delay clock out
    );
end clk_dly;

architecture RTL of clk_dly is
begin
    process (CLK)
    begin
        if(CLK'event and CLK = '0') then
            QOUT <= Din;
        end if;
    end process;
end RTL;