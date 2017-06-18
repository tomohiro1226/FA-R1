--	UART_CLKGEN
--	clock generator test circuit
--  	system-clock:48MHz
--	baudrate:9600bps 
--	receiver-clock:4.8MHz
--  2016.12.17

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity UART_CLKGEN is
	Port (  CLK			: in  std_logic;
			RESET		: in  std_logic;
			TXD_CLK 	: out std_logic;
			RXD_CLK		: out std_logic
	);
end UART_CLKGEN;

architecture RTL of UART_CLKGEN is
	signal TXD_CNT : std_logic_vector(12 downto 0);
	signal RXD_CNT : std_logic_vector( 8 downto 0); 

begin
TXD_clock_generator :
	process( CLK, RESET ) 
	begin
        if( RESET = '1') then
                TXD_CNT <= (others=>'0');
		elsif( CLK'event and CLK = '1') then
			if( TXD_CNT = 4999 ) then	--5000
				TXD_CNT <= (others=>'0');
				TXD_CLK <= '1';
			else
				TXD_CNT <= TXD_CNT + '1';
				TXD_CLK <= '0';
			end if;
		end if;
	end process;

RXD_clock_generator :	
	process( CLK, RESET ) 
	begin
        if( RESET = '1') then
            RXD_CNT <= (others=>'0');
		elsif( CLK'event and CLK = '1') then
			if( RXD_CNT = 311) then --312 : 48MHz / 153600Hz
				RXD_CNT <= (others=>'0');
				RXD_CLK  <= '1';
			else
				RXD_CNT <= RXD_CNT + '1';
				RXD_CLK  <= '0';
			end if;
		end if;
	end process;

end RTL ;