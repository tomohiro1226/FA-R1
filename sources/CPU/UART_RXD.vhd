--    UART_RXD
--    receiver test circuit
--      system-clock:48MHz 
--    baudrate:9600bps data:8bit stop:1bit parity:non
--    2016.12.17

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity UART_RXD is
    Port (
        CLK      : in  std_logic;
        RESET    : in  std_logic;
        RXD_CLK  : in  std_logic;
        RXD_IN   : in  std_logic;
        RXD_STB  : out std_logic;
        DATA_OUT : out std_logic_vector(15 downto 0)
    );
end UART_RXD;

architecture RTL of UART_RXD is
    signal START        : std_logic;
    signal RXD_CLK_CNT  : integer range 0 to 153;

begin
    process( CLK, RESET ) begin
        if( RESET = '1') then
                START       <= '0';
                RXD_CLK_CNT <=  0 ;
                DATA_OUT    <= (others=>'0');
                RXD_STB     <= '0';
        elsif( CLK'event and CLK='1') then
            if(RXD_CLK = '1') then
                if( START = '0') then
                    if( RXD_IN = '0') then  --start bit chek
                        START       <= '1';
                        RXD_CLK_CNT <= 0;
                        RXD_STB     <= '0';
                    end if;
                else
                    case RXD_CLK_CNT is
                        when 8 => --start
                            if( RXD_IN = '1') then
                                START   <= '0';
                            end if;
    
                        when 24 => --data0
                            DATA_OUT(0) <= RXD_IN;
                            
                        when 40 => --data1
                            DATA_OUT(1) <= RXD_IN;
                            
                        when 56 => --data2
                            DATA_OUT(2) <= RXD_IN;
                            
                       when 72 => --data3
                           DATA_OUT(3) <= RXD_IN;
    
                       when  88 => --data4
                           DATA_OUT(4) <= RXD_IN;
                            
                        when 104 => --data5
                            DATA_OUT(5) <= RXD_IN;
    
                        when 120 => --data6
                            DATA_OUT(6) <= RXD_IN;
    
                        when 136 => --data7
                            DATA_OUT(7) <= RXD_IN;
    
                        when 152 => --stop
                            START       <= '0';
                            RXD_STB     <= '1';
        
                        when others => null;
                    end case;
                    RXD_CLK_CNT <= RXD_CLK_CNT + 1;
                end if;
            end if;
        end if;
    end process;

end RTL;
