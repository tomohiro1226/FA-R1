--  FA_R1
--  clk_gen.vhd
--  Fukunaga
--  2017.01.17

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
entity clk_gen is
    port (
        RESET   : in  std_logic;
        CLK     : in  std_logic; --System core clock
        CLK_IF  : out std_logic; --Instruction Fetch clock
        CLK_ID  : out std_logic; --Instruction Decode clock
        CLK_EX  : out std_logic; --Execute clock
        CLK_MEM : out std_logic; --Memory access clock
        CLK_WB  : out std_logic  --Register write back clock
    );
end clk_gen;

architecture RTL of clk_gen is

signal COUNT        : integer range 0 to 5;
signal CLK_Divide   : integer range 0 to 4799999;
begin
    process(CLK, RESET)
    begin
        if( RESET = '1') then
            COUNT      <=  0;
			CLK_Divide <=  0;
            CLK_IF  <= '0';
            CLK_ID  <= '0';
            CLK_EX  <= '0';
            CLK_MEM <= '0';
            CLK_WB  <= '0';

        elsif( CLK'event and CLK = '1' ) then
            if( CLK_Divide = 4799999 ) then
                COUNT <= COUNT + 1;
                case COUNT is
                    when 0 =>
                        CLK_IF  <= '1';
                        CLK_ID  <= '0';
                        CLK_EX  <= '0';
                        CLK_MEM <= '0';
                        CLK_WB  <= '0';
                    when 1 =>
                        CLK_IF  <= '0';
                        CLK_ID  <= '1';
                        CLK_EX  <= '0';
                        CLK_MEM <= '0';
                        CLK_WB  <= '0';
                    when 2 =>
                        CLK_IF  <= '0';
                        CLK_ID  <= '0';
                        CLK_EX  <= '1';
                        CLK_MEM <= '0';
                        CLK_WB  <= '0';
                    when 3 =>
                        CLK_IF  <= '0';
                        CLK_ID  <= '0';
                        CLK_EX  <= '0';
                        CLK_MEM <= '1';
                        CLK_WB  <= '0';
                    when 4 =>
                        CLK_IF  <= '0';
                        CLK_ID  <= '0';
                        CLK_EX  <= '0';
                        CLK_MEM <= '0';
                        CLK_WB  <= '1';
                        COUNT <= 0;
                    when others =>
                        COUNT <= 0;
                end case;
                CLK_Divide <= 0;
            else
                CLK_Divide <= CLK_Divide + 1;
            end if;
        end if;
    end process;
end RTL;