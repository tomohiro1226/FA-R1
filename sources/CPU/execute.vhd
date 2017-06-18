--  FA_R1
--  execute.vhd
--  Fukunaga
--  2017.01.17

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
--use SHL(std_logic_vector,std_logic_vector),
--    SHR(std_logic_vector,std_logic_vector)

entity execute is
    port(
        RESET         : in  std_logic;
        CLK_EX        : in  std_logic;
    --Operation
        OP_CODE       : in  std_logic_vector( 4 downto 0);
        OP_DATA       : in  std_logic_vector( 9 downto 0);
        S_FLG         : in  std_logic; --Source index register flag
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
        STATUS_IN     : in  std_logic_vector(15 downto 0); --Status register in
        STATUS_OUT    : out std_logic_vector(15 downto 0); --Status register out
    --Random access memory
        RAM_REN       : out std_logic; --RAM read enable
        RAM_WEN       : out std_logic; --RAM write enable
        RAM_W_DATA    : out std_logic_vector(15 downto 0); --Write RAM data
        RAM_ADDRESS   : out std_logic_vector( 9 downto 0);
    --Write back Register
        REG_WEN       : out std_logic; --REG write enable
        REG_W_DATA    : out std_logic_vector(15 downto 0); --Write back register data
        REG_ADDRESS   : out std_logic_vector( 4 downto 0);
        REG_B_ADDRESS : in  std_logic_vector( 4 downto 0)
    );
end execute;

architecture RTL of execute is
begin
    process(CLK_EX, RESET)
    begin
        if(RESET = '1') then
            PC_OUT  <= (others=>'0');
            SP_OUT  <= "0000001111111111";
        --REG
            REG_W_DATA  <= (others=>'0');
            REG_ADDRESS <= (others=>'0');
            REG_WEN     <= '0';
        --RAM
            RAM_REN     <= '0';
            RAM_WEN     <= '0';
            RAM_W_DATA  <= (others=>'0');
            RAM_ADDRESS <= (others=>'0');
            STATUS_OUT  <= (others=>'0');

        elsif(CLK_EX'event and CLK_EX = '1') then
            case OP_CODE is
        ----------------------------------------------------
        --  NOP (No operation)                            --
        ----------------------------------------------------
                when "00000" =>
                    REG_WEN <= '0';
                    RAM_REN <= '0';
                    RAM_WEN <= '0';
                    PC_OUT <= PC_IN + 1;

        ----------------------------------------------------
        --  ADDLW k,#s (Add litelal and work)             --
        ----------------------------------------------------
                when "00001" =>
                    if(S_FLG = '1') then
                        REG_W_DATA <= W + (("000000"&OP_DATA) + SI);
                    else
                        REG_W_DATA <= W + ("000000"&OP_DATA);
                    end if;
                    REG_ADDRESS <= "00010"; --W
                    REG_WEN <= '1';
                    RAM_REN <= '0';
                    RAM_WEN <= '0';
                    PC_OUT <= PC_IN + 1;

        ----------------------------------------------------
        --  SUBLW k,#s (Subtract litelal from work)       --
        ----------------------------------------------------
                when "00010" =>
                    if(S_FLG = '1') then
                        REG_W_DATA <= W - (("000000"&OP_DATA) + SI);
                    else
                        REG_W_DATA <= W - ("000000"&OP_DATA);
                        end if;
                    REG_ADDRESS <= "00010"; --W
                    REG_WEN <= '1';
                    RAM_REN <= '0';
                    RAM_WEN <= '0';
                    PC_OUT <= PC_IN + 1;

        ----------------------------------------------------
        --  MOVLW k,#s (Move litelal to work)             --
        ----------------------------------------------------
                when "00011" =>
                    if(S_FLG = '1') then
                        REG_W_DATA <= (("000000"&OP_DATA) + SI);
                    else
                        REG_W_DATA <= ("000000"&OP_DATA);
                    end if;
                    REG_ADDRESS <= "00010"; --W
                    REG_WEN <= '1';
                    RAM_REN <= '0';
                    RAM_WEN <= '0';
                    PC_OUT <= PC_IN + 1;

        ----------------------------------------------------
        --  LD k,#s (Load)                                --
        ----------------------------------------------------
                when "00100" =>
                    if(S_FLG = '1') then
                        RAM_ADDRESS <= OP_DATA + SI(9 downto 0);
                    else
                        RAM_ADDRESS <= OP_DATA;
                    end if;
                    REG_ADDRESS <= "00010"; --W
                    REG_WEN <= '1';
                    RAM_REN <= '1';
                    RAM_WEN <= '0';
                    PC_OUT <= PC_IN + 1;

        ----------------------------------------------------
        --  ST k,#s (Store)                               --
        ----------------------------------------------------
                when "00101" =>
                    if(S_FLG = '1') then
                        RAM_ADDRESS <= OP_DATA + SI( 9 downto 0);
                    else
                        RAM_ADDRESS <= OP_DATA;
                    end if;
                    RAM_W_DATA <= W;
                    REG_WEN <= '0';
                    RAM_REN <= '0';
                    RAM_WEN <= '1';
                    PC_OUT <= PC_IN + 1;

        ----------------------------------------------------
        --  ANDLW k,#s (AND litelal with work)            --
        ----------------------------------------------------
                when "00110" =>
                    if(S_FLG = '1') then
                        REG_W_DATA <= W and (("000000"&OP_DATA) + SI);
                    else
                        REG_W_DATA <= W and ("000000"&OP_DATA);
                    end if;
                    REG_ADDRESS <= "00010"; --W
                    REG_WEN <= '1';
                    RAM_REN <= '0';
                    RAM_WEN <= '0';
                    PC_OUT <= PC_IN + 1;

        ----------------------------------------------------
        --  IORLW k,#s (Inclusive OR litelal with work)   --
        ----------------------------------------------------
                when "00111" =>
                    if(S_FLG = '1') then
                        REG_W_DATA <= W or (("000000"&OP_DATA) + SI);
                    else
                        REG_W_DATA <= W or ("000000"&OP_DATA);
                    end if;
                    REG_ADDRESS <= "00010"; --W
                    REG_WEN <= '1';
                    RAM_REN <= '0';
                    RAM_WEN <= '0';
                    PC_OUT <= PC_IN + 1;

        ----------------------------------------------------
        --  XORLW k,#s (Exclusive OR litelal with work)   --
        ----------------------------------------------------
                when "01000" =>
                    if(S_FLG = '1') then
                        REG_W_DATA <= W xor (("000000"&OP_DATA) + SI);
                    else
                        REG_W_DATA <= W xor ("000000"&OP_DATA);
                    end if;
                    REG_ADDRESS <= "00010"; --W
                    REG_WEN <= '1';
                    RAM_REN <= '0';
                    RAM_WEN <= '0';
                    PC_OUT <= PC_IN + 1;

        ----------------------------------------------------
        --  GOTO k,#s (Go to)                             --
        ----------------------------------------------------
                when "01001" =>
                    if(S_FLG = '1') then
                        PC_OUT( 9 downto 0) <= (OP_DATA + SI( 9 downto 0));
                    else
                        PC_OUT( 9 downto 0) <= OP_DATA;
                    end if;
                    REG_WEN <= '0';
                    RAM_REN <= '0';
                    RAM_WEN <= '0';

        ----------------------------------------------------
        --  CALL k,#s (Call)                              --
        ----------------------------------------------------
                when "01010" =>
                    RAM_ADDRESS <= SP_IN( 9 downto 0);
                    SP_OUT <= SP_IN - 1;
                    RAM_W_DATA <= PC_IN + 1; -- +1 is inserted 2017.01.13
                    if(S_FLG = '1') then
                        PC_OUT( 9 downto 0) <= (OP_DATA + SI( 9 downto 0));
                    else
                        PC_OUT( 9 downto 0) <= OP_DATA;
                    end if;
                    REG_WEN <= '0';
                    RAM_REN <= '0';
                    RAM_WEN <= '1';

        ----------------------------------------------------
        --  BT k,#s (Bit test True)                       --
        ----------------------------------------------------
                when "01011" =>
                    --It reference flag bit to select bit from REG_A.
                    --If select bit is '1' then STATUS(4) set true.
                    if( REG_A(conv_integer(BIT_FLG)) = '1') then
                        STATUS_OUT(4) <= '1'; --Set True
                    else
                        STATUS_OUT(4) <= '0'; --Set False
                    end if;
                    REG_WEN <= '0';
                    RAM_REN <= '0';
                    RAM_WEN <= '0';
                    PC_OUT <= PC_IN + 1;

        ----------------------------------------------------
        --  BF k,#s (Bit test False)                      --
        ----------------------------------------------------
                when "01100" =>
                    --It reference flag bit to select bit from REG_A.
                    --If select bit is '0' then STATUS(4) set true.
                    if( REG_A(conv_integer(BIT_FLG)) = '0') then
                        STATUS_OUT(4) <= '1'; --Set True
                    else
                        STATUS_OUT(4) <= '0'; --Set False
                    end if;
                    REG_WEN <= '0';
                    RAM_REN <= '0';
                    RAM_WEN <= '0';
                    PC_OUT <= PC_IN + 1;

        ----------------------------------------------------
        --  BTFSS (Bit Test F Skip if Set)                --
        ----------------------------------------------------
                --If STATUS(4) is true then skip.
                when "01101" =>
                    if( STATUS_IN(4) = '1') then
                        PC_OUT <= PC_IN + 2;
                    else
                        PC_OUT <= PC_IN + 1;
                    end if;
                    REG_WEN <= '0';
                    RAM_REN <= '0';
                    RAM_WEN <= '0';

        ----------------------------------------------------
        --  BTFSC (Bit Test F Skip if Clear)              --
        ----------------------------------------------------
                when "01110" =>
                    if( STATUS_IN(4) = '0') then
                        PC_OUT <= PC_IN + 2;
                    else
                        PC_OUT <= PC_IN + 1;
                    end if;
                    REG_WEN <= '0';
                    RAM_REN <= '0';
                    RAM_WEN <= '0';

        ----------------------------------------------------
        --  ADDWF f,d (Add work and f)                    --
        ----------------------------------------------------
                when "01111" =>
                    REG_W_DATA <= W + REG_A;
                    REG_ADDRESS <= REG_B_ADDRESS;
                    REG_WEN <= '1';
                    RAM_REN <= '0';
                    RAM_WEN <= '0';
                    PC_OUT <= PC_IN + 1;

        ----------------------------------------------------
        --  SUBWF f,d (Subtract work from f)              --
        ----------------------------------------------------
                when "10000" =>
                    REG_W_DATA <= REG_A - W;
                    REG_ADDRESS <= REG_B_ADDRESS;
                    REG_WEN <= '1';
                    RAM_REN <= '0';
                    RAM_WEN <= '0';
                    PC_OUT <= PC_IN + 1;

        ----------------------------------------------------
        --  MOVF f,d (Move f)                             --
        ----------------------------------------------------
                when "10001" =>
                    REG_W_DATA <= REG_A;
                    REG_ADDRESS <= REG_B_ADDRESS;
                    REG_WEN <= '1';
                    RAM_REN <= '0';
                    RAM_WEN <= '0';
                    PC_OUT <= PC_IN + 1;

        ----------------------------------------------------
        --  SLL f,d (Shift Left Logical)                  --
        ----------------------------------------------------
                when "10010" =>
                    REG_W_DATA <= SHL(W, REG_A);
                    --SHL is defined by ieee.std_logic_unsigned.
                    REG_ADDRESS <= REG_B_ADDRESS;
                    REG_WEN <= '1';
                    RAM_REN <= '0';
                    RAM_WEN <= '0';
                    PC_OUT <= PC_IN + 1;

        ----------------------------------------------------
        --  SRL f,d (Shift Right Logical)                 --
        ----------------------------------------------------
                when "10011" =>
                    REG_W_DATA <= SHR(W, REG_A);
                    --SHR is defined by ieee.std_logic_unsigned.
                    REG_ADDRESS <= REG_B_ADDRESS;
                    REG_WEN <= '1';
                    RAM_REN <= '0';
                    RAM_WEN <= '0';
                    PC_OUT <= PC_IN + 1;

        ----------------------------------------------------
        --  SRA f,d (Shift Right Arithmetic)              --
        ----------------------------------------------------
                when "10100" =>
                    REG_W_DATA <= ( (W and X"8000") or SHR(W, REG_A) );
                    --SHR is defined by ieee.std_logic_unsigned.
                    REG_ADDRESS <= REG_B_ADDRESS;
                    REG_WEN <= '1';
                    RAM_REN <= '0';
                    RAM_WEN <= '0';
                    PC_OUT <= PC_IN + 1;

        ----------------------------------------------------
        --  ANDWF f,d (AND work with f)                   --
        ----------------------------------------------------
                when "10101" =>
                    REG_W_DATA <= W and REG_A;
                    REG_ADDRESS <= REG_B_ADDRESS;
                    REG_WEN <= '1';
                    RAM_REN <= '0';
                    RAM_WEN <= '0';
                    PC_OUT <= PC_IN + 1;
    
        ----------------------------------------------------
        --  IORWF f,d (Inclusive OR work with f)          --
        ----------------------------------------------------
                when "10110" =>
                    REG_W_DATA <= W or REG_A;
                    REG_ADDRESS <= REG_B_ADDRESS;
                    REG_WEN <= '1';
                    RAM_REN <= '0';
                    RAM_WEN <= '0';
                    PC_OUT <= PC_IN + 1;

        ----------------------------------------------------
        --  XORWF f,d (Exclusive OR work with f)          --
        ----------------------------------------------------
                when "10111" =>
                    REG_W_DATA <= W xor REG_A;
                    REG_ADDRESS <= REG_B_ADDRESS;
                    REG_WEN <= '1';
                    RAM_REN <= '0';
                    RAM_WEN <= '0';
                    PC_OUT <= PC_IN + 1;

        ----------------------------------------------------
        --  NOT f,d (Not)                                 --
        ----------------------------------------------------
                when "11000" =>
                    REG_W_DATA <= not REG_A;
                    REG_ADDRESS <= REG_B_ADDRESS;
                    REG_WEN <= '1';
                    RAM_REN <= '0';
                    RAM_WEN <= '0';
                    PC_OUT <= PC_IN + 1;

        ----------------------------------------------------
        --  MOVWF f (Move work to f)                      --
        ----------------------------------------------------
                when "11001" =>
                    REG_W_DATA <= W;
                    REG_ADDRESS <= REG_B_ADDRESS;
                    REG_WEN <= '1';
                    RAM_REN <= '0';
                    RAM_WEN <= '0';
                    PC_OUT <= PC_IN + 1;

        ----------------------------------------------------
        --  PUSH f (Push f)                               --
        ----------------------------------------------------
                when "11010" =>
                    RAM_W_DATA <= REG_B;
                    RAM_ADDRESS <= SP_IN( 9 downto 0);
                    SP_OUT <= SP_IN - 1;
                    REG_WEN <= '0';
                    RAM_REN <= '0';
                    RAM_WEN <= '1';
                    PC_OUT <= PC_IN + 1;

        ----------------------------------------------------
        --  POP f (Pop f)                                 --
        ----------------------------------------------------
                when "11011" =>
                    if( not(SP_IN = 1024) ) then
                        RAM_ADDRESS <= SP_IN( 9 downto 0) + 1;
                        SP_OUT <= SP_IN + 1;
                        REG_ADDRESS <= REG_B_ADDRESS;
                        REG_WEN <= '1';
                        RAM_REN <= '1';
                        RAM_WEN <= '0';
                        PC_OUT <= PC_IN + 1;
                    end if;

        ----------------------------------------------------
        --  CMP f (Compare f with w)                      --
        ----------------------------------------------------
                when "11100" =>
                    if( W = REG_B ) then
                        STATUS_OUT(4) <= '1'; --Set True
                    else
                        STATUS_OUT(4) <= '0'; --Set False,others true
                    end if;
                    REG_WEN <= '0';
                    RAM_REN <= '0';
                    RAM_WEN <= '0';
                    PC_OUT <= PC_IN + 1;

        ----------------------------------------------------
        --  HLT (Halt)                                    --
        ----------------------------------------------------
                when "11101" =>
                when others =>
            end case;
        end if;
    end process;
end RTL;
