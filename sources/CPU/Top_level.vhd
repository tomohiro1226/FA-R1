--  FA_R1
--  Top_level.vhd
--  Fukunaga
--  2017.01.17

-----------------------------------------------------
--          Libraries                              --
-----------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

-----------------------------------------------------
--          Entity                                 --
-----------------------------------------------------
entity Top_level is
    port(
        CLK   : in  std_logic;
        RST   : in  std_logic;
        RXD   : in  std_logic;
        TXD   : out std_logic;
    --  Display
        W_LED    : out std_logic_vector(15 downto 0);
        PC_LED   : out std_logic_vector( 9 downto 0);
        LED_IF   : out std_logic;
        LED_ID   : out std_logic;
        LED_EX   : out std_logic;
        LED_MEM  : out std_logic;
        LED_WB   : out std_logic
    );
end Top_level;

-----------------------------------------------------
--          Architecture                           --
-----------------------------------------------------
architecture RTL of Top_level is

    component clk_gen
        port (
            RESET   : in  std_logic;
            CLK     : in  std_logic;
            CLK_IF  : out std_logic; --Instruction Fetch clock
            CLK_ID  : out std_logic; --Instruction Decode clock
            CLK_EX  : out std_logic; --Execute clock
            CLK_MEM : out std_logic; --Memory access clock
            CLK_WB  : out std_logic  --Register write back clock
        );
    end component;

    component clk_dly
        port (
            CLK  : in  std_logic;
            Din  : in  std_logic;
            QOUT : out std_logic
        );
    end component;

    component fetch
        port (
            address  : IN  STD_LOGIC_VECTOR( 9 DOWNTO 0); --conect PC( 9 downto 0)
            inclock  : IN  STD_LOGIC;
            outclock : IN  STD_LOGIC;
            q        : OUT STD_LOGIC_VECTOR(15 DOWNTO 0) --conect ROM_DATA
        );
    end component;

    component decode
        port (
            RESET    : in  std_logic;
            CLK_ID   : in  std_logic;
            ROM_DATA : in  std_logic_vector(15 downto 0);
            OP_CODE  : out std_logic_vector( 4 downto 0);
            OP_DATA  : out std_logic_vector( 9 downto 0);
            S_FLG    : out std_logic --Source index register flag
        );
    end component;

    component reg_id
        port (
            RESET       : in  std_logic;
            CLK_ID      : in  std_logic;
            No_REG_read : in  std_logic_vector( 4 downto 0); --conect ROM_DATA(x downto y)
            REG_R_DATA  : out std_logic_vector(15 downto 0); --conect REG_A,REG_B
        --List of register
--operated by execute. PC          : in  std_logic_vector(15 downto 0); --0x00 Program counter
--operated by execute. SP          : in  std_logic_vector(15 downto 0); --0x01 Stack pointer
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
    end component;

    component execute
        port(
            RESET         : in  std_logic;
            CLK_EX        : in  std_logic;
        --Operation
            OP_CODE       : in  std_logic_vector( 4 downto 0);
            OP_DATA       : in  std_logic_vector( 9 downto 0);
            S_FLG         : in  std_logic;                     --Source index register flag
            BIT_FLG       : in  std_logic_vector( 4 downto 0); --Bit flag
        --Register
            PC_IN         : in  std_logic_vector(15 downto 0); --Program counter in
            PC_OUT        : out std_logic_vector(15 downto 0); --Program counter out
            REG_A         : in  std_logic_vector(15 downto 0); --conect REG_DATA(reg_id.vhd)
            REG_B         : in  std_logic_vector(15 downto 0); --conect REG_DATA(reg_id.vhd)
            SP_IN         : in  std_logic_vector(15 downto 0); --Stack pointer in
            SP_OUT        : out std_logic_vector(15 downto 0); --Stack pointer out
            W             : in  std_logic_vector(15 downto 0); --Working register
            SI            : in  std_logic_vector(15 downto 0); --Source index register
            STATUS_IN     : in  std_logic_vector(15 downto 0); --Status register
            STATUS_OUT    : out std_logic_vector(15 downto 0); --Status register
        --Random access memory
            RAM_REN       : out std_logic;                     --RAM read enable
            RAM_WEN       : out std_logic;                     --RAM write enable
            RAM_W_DATA    : out std_logic_vector(15 downto 0); --Write RAM data
            RAM_ADDRESS   : out std_logic_vector( 9 downto 0);
        --Write back Register
            REG_WEN       : out std_logic;                     --REG write enable
            REG_W_DATA    : out std_logic_vector(15 downto 0);
            REG_ADDRESS   : out std_logic_vector( 4 downto 0);
            REG_B_ADDRESS : in  std_logic_vector( 4 downto 0)
        );
    end component;

    component ram
        port(
            RESET           : in  std_logic;
            CLK_MEM         : in  std_logic;
            CLK_WB          : in  std_logic;
            RAM_WEN         : in  std_logic;
            RAM_REN         : in  std_logic;
            RAM_ADDRESS     : in  std_logic_vector( 9 downto 0); --address to access memory
            RAM_W_DATA      : in  std_logic_vector(15 downto 0); --Data to memory
            REG_W_DATA_R_W  : out std_logic_vector(15 downto 0); --Data from memory
            REG_W_DATA_E_R  : in  std_logic_vector(15 downto 0)
        );
    end component;

    component reg_wb
        port(
            RESET       : in  std_logic;
            CLK_WB      : in  std_logic;
            REG_WEN     : in  std_logic;
        --REG_A or REG_B
            REG_ADDRESS : in  std_logic_vector( 4 downto 0); --conect REG_ADDRESS
            REG_W_DATA  : in  std_logic_vector(15 downto 0);
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
          --STATUS      : out std_logic_vector(15 downto 0); --0x14 Status register
            PORTA       : out std_logic_vector(15 downto 0); --0x15 Port A register
            PORTB       : out std_logic_vector(15 downto 0); --0x16 Port B register
--Read only. UART_RX    : out std_logic_vector(15 downto 0); --0x17 UART Receiver
            UART_TX     : out std_logic_vector(15 downto 0)  --0x18 UART Transmitter
        );
    end component;

    component UART_TOP
        port(
            CLK         : in  std_logic;    -- SYSTEM CLOCK 48MHz
            RESET       : in  std_logic;
            TXD         : out std_logic;
            RXD         : in  std_logic;
            UART_RX     : out std_logic_vector(15 downto 0);
            UART_TX     : in  std_logic_vector(15 downto 0);
            SSR1        : out std_logic_vector(15 downto 0)
        );
    end component;

-----------------------------------------------------
--          Signals                                --
-----------------------------------------------------
--Reset
	signal RESET            : std_logic; --Pull up switch
    signal RST_COUNT        : integer range 0 to 4;
--clock
    signal CLK_IF           : std_logic; --Instruction Fetch
    signal CLK_ID           : std_logic; --Instruction Decode
    signal CLK_EX           : std_logic; --Execute
    signal CLK_MEM          : std_logic; --Memory access
    signal CLK_WB           : std_logic; --Write back register
    signal CLK_WB_DLY       : std_logic; --Delay Write back register
--Operation
    signal OP_CODE          : std_logic_vector( 4 downto 0);
    signal OP_DATA          : std_logic_vector( 9 downto 0);
    signal S_FLG            : std_logic;                     --Source index register flag
--Read only memory
    signal ROM_DATA         : std_logic_vector(15 downto 0); --conect q, Data passing in fetch
--Register
    signal PC               : std_logic_vector(15 downto 0); --0x00 Program counter
    signal SP               : std_logic_vector(15 downto 0); --0x01 Stack pointer
    signal W                : std_logic_vector(15 downto 0); --0x02 Working register
    signal SI               : std_logic_vector(15 downto 0); --0x03 Source index register
    signal FR_0             : std_logic_vector(15 downto 0); --0x04 File register 0
    signal FR_1             : std_logic_vector(15 downto 0); --0x05 File register 1
    signal FR_2             : std_logic_vector(15 downto 0); --0x06 File register 2
    signal FR_3             : std_logic_vector(15 downto 0); --0x07 File register 3
    signal FR_4             : std_logic_vector(15 downto 0); --0x08 File register 4
    signal FR_5             : std_logic_vector(15 downto 0); --0x09 File register 5
    signal FR_6             : std_logic_vector(15 downto 0); --0x0A File register 6
    signal FR_7             : std_logic_vector(15 downto 0); --0x0B File register 7
    signal FR_8             : std_logic_vector(15 downto 0); --0x0C File register 8
    signal FR_9             : std_logic_vector(15 downto 0); --0x0D File register 9
    signal FR_A             : std_logic_vector(15 downto 0); --0x0E File register A
    signal FR_B             : std_logic_vector(15 downto 0); --0x0F File register B
    signal FR_C             : std_logic_vector(15 downto 0); --0x10 File register C
    signal FR_D             : std_logic_vector(15 downto 0); --0x11 File register D
    signal FR_E             : std_logic_vector(15 downto 0); --0x12 File register E
    signal FR_F             : std_logic_vector(15 downto 0); --0x13 File register F
    signal STATUS           : std_logic_vector(15 downto 0); --0x14 Status register
    signal PORTA            : std_logic_vector(15 downto 0); --0x15 Port A register
    signal PORTB            : std_logic_vector(15 downto 0); --0x16 Port B register]
    signal SSR1             : std_logic_vector(15 downto 0); --0x19 Serial status register
--use execute register
    signal REG_WEN          : std_logic;                     --Register write enable
    signal REG_ADDRESS      : std_logic_vector( 4 downto 0);
    signal REG_W_DATA_E_R   : std_logic_vector(15 downto 0); --connect from execute to ram
    signal REG_W_DATA_R_W   : std_logic_vector(15 downto 0); --connect from ram to reg_wb
--Write back data
    signal REG_A            : std_logic_vector(15 downto 0); --conect REG_DATA(reg_id.vhd)
    signal REG_B            : std_logic_vector(15 downto 0); --conect REG_DATA(reg_id.vhd)
--Random access memory
    signal RAM_REN          : std_logic;                     --RAM read enable
    signal RAM_WEN          : std_logic;                     --RAM write enable
    signal RAM_ADDRESS      : std_logic_vector( 9 downto 0);
    signal RAM_W_DATA       : std_logic_vector(15 downto 0); --RAM write data
--UART
    --Receiver
    signal UART_RX          : std_logic_vector(15 downto 0); --0x17 UART Receiver
    --Transmitter
    signal UART_TX          : std_logic_vector(15 downto 0); --0x18 UART Transmitter

-----------------------------------------------------
--          Port maps                              --
-----------------------------------------------------
    begin

    C1  :   clk_gen port map(
        --------------------------------
        --  clk_gen,       Top level  --
        --------------------------------
            RESET           => RESET,
            CLK             => CLK,
            CLK_IF          => CLK_IF,
            CLK_ID          => CLK_ID,
            CLK_EX          => CLK_EX,
            CLK_MEM         => CLK_MEM,
            CLK_WB          => CLK_WB
        );

    C2  :   clk_dly port map (
        --------------------------------
        --  ckl_dly,       Top level  --
        --------------------------------
            CLK             => CLK,
            Din             => CLK_WB,
            QOUT            => CLK_WB_DLY
        );


    C3  :   fetch port map(
        --------------------------------
        --  fetch,         Top level  --
        --------------------------------
            address         => PC( 9 downto 0),
            inclock         => CLK_WB_DLY,
            outclock        => CLK_IF,
            q               => ROM_DATA
        );

    C4  :   decode port map(
        --------------------------------
        --  decode,        Top level  --
        --------------------------------
            RESET           => RESET,
            CLK_ID          => CLK_ID,
            ROM_DATA        => ROM_DATA,
            OP_CODE         => OP_CODE,
            OP_DATA         => OP_DATA,
            S_FLG           => S_FLG
        );

    C5  :   reg_id port map(
        --------------------------------
        --  reg_id,        Top level  --
        --------------------------------
            RESET           => RESET,
            CLK_ID          => CLK_ID,
            --REG_A
            No_REG_read     => ROM_DATA(10 downto 6),
            REG_R_DATA      => REG_A,
            --List of register
            --PC              => PC,
            --SP              => SP,
            W               => W,
            SI              => SI,
            FR_0            => FR_0,
            FR_1            => FR_1,
            FR_2            => FR_2,
            FR_3            => FR_3,
            FR_4            => FR_4,
            FR_5            => FR_5,
            FR_6            => FR_6,
            FR_7            => FR_7,
            FR_8            => FR_8,
            FR_9            => FR_9,
            FR_A            => FR_A,
            FR_B            => FR_B,
            FR_C            => FR_C,
            FR_D            => FR_D,
            FR_E            => FR_E,
            FR_F            => FR_F,
            STATUS          => STATUS,
            PORTA           => PORTA,
            PORTB           => PORTB,
            UART_RX         => UART_RX,
            UART_TX         => UART_TX,
            SSR1            => SSR1
        );

    C6  :   reg_id port map(
        --------------------------------
        --  reg_id,        Top_level  --
        --------------------------------
            RESET           => RESET,
            CLK_ID          => CLK_ID,
            --REG_B
            No_REG_read     => ROM_DATA(5 downto 1),
            REG_R_DATA      => REG_B,
            --List of register
            --PC              => PC,
            --SP              => SP,
            W               => W,
            SI              => SI,
            FR_0            => FR_0,
            FR_1            => FR_1,
            FR_2            => FR_2,
            FR_3            => FR_3,
            FR_4            => FR_4,
            FR_5            => FR_5,
            FR_6            => FR_6,
            FR_7            => FR_7,
            FR_8            => FR_8,
            FR_9            => FR_9,
            FR_A            => FR_A,
            FR_B            => FR_B,
            FR_C            => FR_C,
            FR_D            => FR_D,
            FR_E            => FR_E,
            FR_F            => FR_F,
            STATUS          => STATUS,
            PORTA           => PORTA,
            PORTB           => PORTB,
            UART_RX         => UART_RX,
            UART_TX         => UART_TX,
            SSR1            => SSR1
        );

    C7  :   execute port map(
        --------------------------------
        --  execute,       Top level  --
        --------------------------------
            RESET           => RESET,
            CLK_EX          => CLK_EX,
            --Operation
            OP_CODE         => OP_CODE,
            OP_DATA         => OP_DATA,
            S_FLG           => S_FLG,
            BIT_FLG         => ROM_DATA(5 downto 1),
            --Register
            PC_IN           => PC,
            PC_OUT          => PC,
            REG_A           => REG_A,
            REG_B           => REG_B,
            SP_IN           => SP,
            SP_OUT          => SP,
            W               => W,
            SI              => SI,
            STATUS_IN       => STATUS,
            STATUS_OUT      => STATUS,
            --Random access memory
            RAM_REN         => RAM_REN,
            RAM_WEN         => RAM_WEN,
            RAM_W_DATA      => RAM_W_DATA,
            RAM_ADDRESS     => RAM_ADDRESS,
            --Register
            REG_WEN         => REG_WEN,
            REG_W_DATA      => REG_W_DATA_E_R,
            REG_ADDRESS     => REG_ADDRESS,
            REG_B_ADDRESS   => OP_DATA(4 downto 0)
        );

    C8  :   ram port map(
        --------------------------------
        --  ram,           Top level  --
        --------------------------------
            RESET           => RESET,
            CLK_MEM         => CLK_MEM,
            CLK_WB          => CLK_WB,
            RAM_REN         => RAM_REN,
            RAM_WEN         => RAM_WEN,
            RAM_ADDRESS     => RAM_ADDRESS,
            RAM_W_DATA      => RAM_W_DATA,
            REG_W_DATA_R_W  => REG_W_DATA_R_W,
            REG_W_DATA_E_R  => REG_W_DATA_E_R
        );

    C9  :   reg_wb port map(
        --------------------------------
        --  reg_wb,        Top level  --
        --------------------------------
            RESET           => RESET,
            CLK_WB          => CLK_WB,
            REG_WEN         => REG_WEN,
            --REG_A or REG_B
            REG_ADDRESS     => REG_ADDRESS,
            REG_W_DATA      => REG_W_DATA_R_W,
            --List of register
            --PC              => PC,
            --SP              => SP,
            W               => W,
            SI              => SI,
            FR_0            => FR_0,
            FR_1            => FR_1,
            FR_2            => FR_2,
            FR_3            => FR_3,
            FR_4            => FR_4,
            FR_5            => FR_5,
            FR_6            => FR_6,
            FR_7            => FR_7,
            FR_8            => FR_8,
            FR_9            => FR_9,
            FR_A            => FR_A,
            FR_B            => FR_B,
            FR_C            => FR_C,
            FR_D            => FR_D,
            FR_E            => FR_E,
            FR_F            => FR_F,
            --STATUS          => STATUS,
            PORTA           => PORTA,
            PORTB           => PORTB,
            --UART_RX         => UART_RX,
            UART_TX         => UART_TX
        );

    C10 :   UART_TOP port map(
        --------------------------------
        --  UART_TOP,      Top level  --
        --------------------------------
            CLK             => CLK,
            RESET           => RESET,
            TXD             => TXD,
            RXD             => RXD,
            UART_RX         => UART_RX,
            UART_TX         => UART_TX,
            SSR1            => SSR1
        );

-----------------------------------------------------
--          Working register display               --
-----------------------------------------------------
    --W_LED <= "1111111111111111";
    W_LED <= W;
    --W_LED(0)  <= '0';
    --W_LED(1)  <= '0';
    --W_LED(2)  <= '0';
    --W_LED(3)  <= '0';
    --W_LED(4)  <= '0';
    --W_LED(5)  <= '0';
    --W_LED(6)  <= '0';
    --W_LED(7)  <= '0';
    --W_LED(8)  <= '0';
    --W_LED(9)  <= '0';
    --W_LED(10) <= '0';
    --W_LED(11) <= '0';
    --W_LED(12) <= '0';
    --W_LED(13) <= '0';
    --W_LED(14) <= '0';
    --W_LED(15) <= '0';

-----------------------------------------------------
--          Program counter display                --
-----------------------------------------------------
    --PC_LED <= "1111111111";
    PC_LED <= PC(9 downto 0);
    --PC_LED(0)  <= '0';
    --PC_LED(1)  <= '0';
    --PC_LED(2)  <= '0';
    --PC_LED(3)  <= '0';
    --PC_LED(4)  <= '0';
    --PC_LED(5)  <= '0';
    --PC_LED(6)  <= '0';
    --PC_LED(7)  <= '0';
    --PC_LED(8)  <= '0';
    --PC_LED(9)  <= '0';
-----------------------------------------------------
--          Clock display                          --
-----------------------------------------------------
    LED_IF  <= CLK_IF;
    LED_ID  <= CLK_ID;
    LED_EX  <= CLK_EX;
    LED_MEM <= CLK_MEM;
    LED_WB  <= CLK_WB;

    --LED_IF  <= OP_CODE(0);
    --LED_ID  <= OP_CODE(1);
    --LED_EX  <= OP_CODE(2);
    --LED_MEM <= OP_CODE(3);
    --LED_WB  <= OP_CODE(4);

-----------------------------------------------------
--          RESET invert 1/5 system Clock          --
-----------------------------------------------------
process(CLK)
begin
    if(CLK'event and CLK = '1') then
        if(RST_COUNT = 4) then
            RESET <= not RST;
        else
            RESET <= '1';
            RST_COUNT <= RST_COUNT + 1;
        end if;
    end if;
end process;
-----------------------------------------------------

end RTL;
