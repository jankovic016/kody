library ieee;
use ieee.std_logic_1164.all;

-- Input/output description
entity top is port (
    BTN0: in std_logic;     -- button 0
    BTN1: in std_logic;     -- button 1
    SW0: in std_logic;      -- switch 0
    SW1: in std_logic;      -- switch 1
    LED: out std_logic_vector(3 downto 0);
    D_POS: out std_logic_vector(3 downto 0);    -- display positions
    D_SEG: out std_logic_vector(6 downto 0)     -- display segments
);
end top;

--Internal structure description
architecture Behavioral of top is
signal sum: std_logic_vector(2 downto 0);
signal a,b: std_logic_vector(1 downto 0); 
signal c,c0: std_logic;
signal y0,y1: std_logic;                    -- internal signals

begin
    -------------------
    -- two-bit adder --
    -------------------
    -- 1st bit
     sum(0) <= y0; --...WRITE CODE HERE...
    a(0)  <= not BTN1;
    a(1)  <= not BTN0;
    b(0)  <= not SW0;
    b(1)  <= not SW1;
    
    y0 <= a(0) xor b(0);
    c0 <= a(0) and b(0);
    
    -- 2nd bit
     sum(1) <= y1; -- ...WRITE CODE HERE...
    y1 <= ( a(1) and not b(1) and not c0) or (not a(1) and  b(1) and not c0) or ( not a(1) and not b(1) and  c0) or ( a(1) and  b(1) and c0);
    
    
    -- 3rd bit (carry)
     sum(2) <= c; --...WRITE CODE HERE...
    
    c <= (a(1) and b(1)) or (c0 and a(1)) or (c0 and b(1));
    
    
    -------------------------------------
    -- result to seven-segment display --
    -------------------------------------
    with sum select D_SEG <=        --          0
        "1111001" when "001",       -- 1       ---
        "0100100" when "010",       -- 2    5 |   | 1
        "0110000" when "011",       -- 3       ---   <- 6
        "0011001" when "100",       -- 4    4 |   | 2
        "0010010" when "101",       -- 5       ---
        "0000010" when "110",       -- 6        3
        -- ...WRITE CODE HERE...
        "1000000" when others;      -- 0

    -- only one seven-segment display is used; active low
    D_POS(3 downto 0) <= "1110";    -- set bus value in quotation marks

    ----------------------------------
    -- display input values at LEDs --
    ----------------------------------
    LED(0) <= BTN0;
    LED(1) <=  BTN1;
    LED(2) <= SW0;
    LED(3) <= SW1;
end Behavioral;
