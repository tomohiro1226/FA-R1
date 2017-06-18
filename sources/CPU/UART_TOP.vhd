--  UART_TOP
--  2016.12.17

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity UART_TOP is
    Port (  CLK         : in  std_logic;    -- SYSTEM CLOCK 48MHz
            RESET       : in  std_logic;    -- RESET
            TXD         : out std_logic;
            RXD         : in  std_logic;
            UART_RX     : out std_logic_vector(15 downto 0);
            UART_TX     : in  std_logic_vector(15 downto 0);
            SSR1        : out std_logic_vector(15 downto 0)
    );
end UART_TOP;

architecture RTL of UART_TOP is

component UART_CLKGEN
    Port (  CLK         : in  std_logic;
            RESET       : in  std_logic;
            TXD_CLK     : out std_logic;
            RXD_CLK     : out std_logic
    );
end component;

component UART_TXD
    Port (  CLK         : in  std_logic;
            RESET       : in  std_logic;
            TXD_CLK     : in  std_logic;
            DATA_IN     : in  std_logic_vector(15 downto 0);
            TXD_STB     : in  std_logic;
            TXD_BUSY    : out std_logic;
            TXD_OUT     : out std_logic
    );
end component;

component UART_RXD
    Port (  CLK         : in  std_logic;
            RESET       : in  std_logic;
            RXD_CLK     : in  std_logic;
            RXD_IN      : in  std_logic;
            RXD_STB     : out std_logic;
            DATA_OUT    : out std_logic_vector(15 downto 0)
    );
end component;

    signal RXD_CLK      : std_logic;
    signal RXD_STB      : std_logic;
    signal RXD_DATA     : std_logic_vector(15 downto 0); 

    signal TXD_CLK      : std_logic;
    signal TXD_BUSY     : std_logic;
    signal TXD_DATA     : std_logic_vector(15 downto 0);
    signal TXD_STB      : std_logic;

begin

    U1 : UART_CLKGEN port map (
            CLK         =>  CLK, 
            RESET       =>  RESET, 
            TXD_CLK     =>  TXD_CLK,
            RXD_CLK     =>  RXD_CLK
        );

    U2 : UART_RXD port map ( 
            CLK         =>  CLK, 
            RESET       =>  RESET, 
            RXD_CLK     =>  RXD_CLK, 
            RXD_IN      =>  RXD, 
            RXD_STB     =>  RXD_STB, 
            DATA_OUT    =>  RXD_DATA
        );

    U3 : UART_TXD port map ( 
            CLK         =>  CLK, 
            RESET       =>  RESET, 
            TXD_CLK     =>  TXD_CLK, 
            DATA_IN     =>  TXD_DATA,
            TXD_STB     =>  TXD_STB,
            TXD_BUSY    =>  TXD_BUSY, 
            TXD_OUT     =>  TXD
        );

-----------------------------------------------------------
--TXD
-----------------------------------------------------------
    process(CLK, RESET) 
    begin
        if(RESET = '1') then
            TXD_STB <= '0';
            TXD_DATA <= (others=>'0');
        elsif( CLK'event and CLK = '1') then
            if( TXD_BUSY = '0' and TXD_STB = '0' ) then
                if( UART_TX /= TXD_DATA ) then --if new data
                    TXD_DATA <= UART_TX; --data transmission
                    TXD_STB     <=  '1';
                end if;
            else
                TXD_STB     <=  '0';
            end if;
        end if;
    end process;


-----------------------------------------------------------
--RXD
-----------------------------------------------------------
    process( CLK, RESET ) 
    begin
        if (RESET = '1') then
            UART_RX <= (others=>'0');
        elsif( CLK'event and CLK = '1') then
            if( RXD_STB = '1') then --When receiving data
                UART_RX <= RXD_DATA;
            end if;
        end if;
    end process;

-----------------------------------------------------------
--  set SSR1 register
-----------------------------------------------------------
    process( CLK, RESET )
    begin
        if( RESET = '1')then
            SSR1 <= (others=>'0');
        elsif( CLK'event and CLK = '1') then
            SSR1(6) <= TXD_BUSY;
            SSR1(5) <= RXD_STB;
        end if;
    end process;
-----------------------------------------------------------
end RTL;

