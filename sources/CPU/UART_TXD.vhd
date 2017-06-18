--	UART_TXD
--	transmitter test circuit
--  	system-clock:48MHz 
--	baudrate:9600bps data:8bit stop:1bit parity:non
--  2016.12.17

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity UART_TXD is
	Port (
		CLK		 : in  std_logic;
		RESET	 : in  std_logic;
		TXD_CLK  : in  std_logic;
		TXD_STB  : in  std_logic;
		DATA_IN  : in  std_logic_vector(15 downto 0);
		TXD_BUSY : out std_logic;
		TXD_OUT	 : out std_logic
	);
end UART_TXD;

architecture RTL of UART_TXD is
	signal	TRANS_STATE 	: integer range 0 to 9;
	signal	TXD_BUSY_FLG	: std_logic;

begin
	process( CLK, RESET ) begin
        if( RESET = '1') then
            TXD_OUT         <= '1';
            TXD_BUSY        <= '0';
            TXD_BUSY_FLG    <= '0';
            TRANS_STATE     <= 0;
		elsif( CLK'event and CLK='1') then
			if( TXD_BUSY_FLG = '0' and TXD_STB = '1' ) then
				TXD_BUSY		<= '1';
				TXD_BUSY_FLG    <= '1';
			elsif( TXD_CLK = '1' and TXD_BUSY_FLG = '1' ) then
				case TRANS_STATE is
					when 0 => 
						TXD_OUT		<= '0';
						TRANS_STATE	<= 1;
					when 1 => 
						TXD_OUT		<= DATA_IN(0);
						TRANS_STATE	<= 2;
					when 2 => 
						TXD_OUT 	<= DATA_IN(1);
						TRANS_STATE	<= 3;
					when 3 => 
						TXD_OUT		<= DATA_IN(2);
						TRANS_STATE	<= 4;
					when 4 => 
						TXD_OUT		<= DATA_IN(3);
						TRANS_STATE	<= 5;
					when 5 => 
						TXD_OUT		<= DATA_IN(4);
						TRANS_STATE	<= 6;
					when 6 => 
						TXD_OUT		<= DATA_IN(5);
						TRANS_STATE	<= 7;
					when 7 => 
						TXD_OUT		<= DATA_IN(6);
						TRANS_STATE	<= 8;
					when 8 => 
						TXD_OUT		<= DATA_IN(7);
						TRANS_STATE	<= 9;
					when 9 => 
						TXD_OUT		<= '1';
						TXD_BUSY  	<= '0';
						TXD_BUSY_FLG<= '0';
						TRANS_STATE	<= 0;
					when others => null;
				end case;
			end if;
		end if;
	end process;
end RTL;
