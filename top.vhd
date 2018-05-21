library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;    -- needed for +/- operations

-- Input/output description
entity top is
    port (
        BTN0: in std_logic;
        SW0: in std_logic; 
        CLK: in std_logic;
        CLK250: in std_logic;
        
        LED: out std_logic_vector(3 downto 0);
        D_POS: out std_logic_vector(3 downto 0);
        D_SEG: out std_logic_vector(6 downto 0)
    );
end top;

-- Internal structure description
architecture Behavioral of top is
    -- internal signal definitions
    signal clk_500: std_logic := '0';
    signal tmp_500: std_logic_vector(11 downto 0) := x"000";    -- hexadecimal value
    signal dec: std_logic_vector(3 downto 0) := "0000";         -- binary value
    
    signal clk_250: std_logic := '0';
    signal tmp_250: std_logic_vector(11 downto 0) := x"000";    -- hexadecimal value
    signal dec1: std_logic_vector(3 downto 0) := "0000";         -- binary value
    
     signal clk_10: std_logic := '0';
    signal tmp_10: std_logic_vector(11 downto 0) := x"000";    -- hexadecimal value
    signal dec2: std_logic_vector(3 downto 0) := "0000";         -- binary value
     signal hex: std_logic_vector(3 downto 0) := "0000";     
    
      signal position: std_logic_vector(3 downto 0) := "0000";    
begin
    -----------------------------------------------------------------------------------------
    -- clock divider to 500 ms --
    -----------------------------------------------------------------------------------------
    -- increment auxiliary counter every rising edge of CLK
    -- if you meet half a period of 500 ms invert clk_500
    process (CLK)
    begin
        if rising_edge(CLK) then
            tmp_500 <= tmp_500 + 1;
            if tmp_500 = x"9c4" then
                tmp_500 <= x"000";
                clk_500 <= not clk_500;
            end if;
        end if;
    end process;

    ---------------------
    -- decimal counter --
    ---------------------
    process (clk_500)
    begin
        if rising_edge(clk_500) then
            if BTN0 = '0' then      -- synchronous RESET
                dec <= "0000";
            else 
                dec <= dec + 1;     -- decimal counter
                -- if dec >= "1001" then
                -- ...WRITE CODE HERE...
                
                
                
                
            end if;
        end if;
    end process;
    
    ------------------------------ --------------------------------------------------------------250 ms
    process (CLK)
    begin
        if rising_edge(CLK) then
            tmp_250 <= tmp_250 + 1;
            if tmp_250 = x"4E2" then
                tmp_250 <= x"000";
                clk_250 <= not clk_250;
            end if;
        end if;
    end process;
    
    process (clk_250)
    begin
        if rising_edge(clk_250) then
            if BTN0 = '0' then      -- synchronous RESET
                dec <= "0000";
            else 
                dec1 <= dec1 + 1;     -- decimal counter
                -- if dec >= "1001" then
                -- ...WRITE CODE HERE.
                          
                
            end if;
        end if;
    end process;
    
    -------------------------------------------------------------------------------------------------10ms
     process (CLK)
    begin
        if rising_edge(CLK) then
            tmp_10 <= tmp_10 + 1;
            if tmp_100 = x"032" then
                tmp_10<= x"000";
                clk_10 <= not clk_10;
            end if;
        end if;
    end process;
    
    process (clk_10)
    begin
        if rising_edge(clk_10) then
            if position = "0111"
            then   hex <= dec;     -- synchronous RESET
                   position <= "1110"
            else 
                hex <= dec2 ;     
                position <=  "0111"

                          
                
            end if;
        end if;
    end process;

    ----------------------------------------------------------------------------------------------
    -- counter to seven-segment display --
    --------------------------------------
    with hex select                         --          0
        D_SEG <= "1111001" when "0001",     -- 1       ---
                 "0100100" when "0010",     -- 2    5 |   | 1
                 "0110000" when "0011",     -- 3       ---   <- 6
                 "0011001" when "0100",     -- 4    4 |   | 2
                 "0010010" when "0101",     -- 5       ---
                 "0000010" when "0110",     -- 6        3
                 "1111000" when "0111",     -- 7
                 "0000000" when "1000",     -- 8
                 "0010000" when "1001",     -- 9
                 "0001000" when "1010",     -- A    10
                 "0000011" when "1011",     -- B    11
                 "1000110" when "1100",     -- C    12
                 "0100001" when "1101",     -- D    13
                 "0000110" when "1110",     -- E    14
                 "0001110" when "1111",     -- F    15
                 -- ...WRITE CODE HERE...
                 "1000000" when others;     -- 0

    -- only one seven-segment display is used; active low
    D_POS <= position;
    
    
    

    -----------------------------------
    -- display counter value at LEDs --
    -----------------------------------
    LED <= not dec;
end Behavioral;
