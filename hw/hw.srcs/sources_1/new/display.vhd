library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.constants_pkg.all;

entity display is
    port (
        clk : in    std_logic;
        rst : in    std_logic;
        num : in    std_logic_vector(THRESHOLD_WIDTH - 1 downto 0);
        an  : out   std_logic_vector(AN_WIDTH - 1 downto 0);
        seg : out   std_logic_vector(SEG_WIDTH - 1 downto 0)
    );
end display;

architecture arch of display is
    constant N      : integer := 18; -- Refresh rate of display: (50 * 10^6) / 2^N = 190 Hz with N = 18
    signal q_reg    : unsigned(N - 1 downto 0);
    signal q_next   : unsigned(N - 1 downto 0);
    signal sel      : std_logic_vector(1 downto 0);
    
    -- Binary to decimal
    signal thousands: integer range 0 to 9;
    signal hundreds : integer range 0 to 9;
    signal tens     : integer range 0 to 9;
    signal singles  : integer range 0 to 9;
    
begin
    process (clk, rst)
    begin
        if rst = '1' then
            q_reg <= (others => '0');
        elsif rising_edge(clk) then
            q_reg <= q_next;
        end if;
    end process;
    
    q_next <= q_reg + 1;
    
    process (num)
        variable num_int : integer;
    begin
        num_int     := to_integer(unsigned(num));
        thousands   <= num_int          / 1000;
        hundreds    <= num_int mod 1000 / 100;
        tens        <= num_int mod 100  / 10;
        singles     <= num_int mod 10;
    end process;
    
    sel <= std_logic_vector(q_reg(N - 1 downto N - 2));
    
    process (sel, num)
    begin
        case sel is 
            when "00" =>
                an  <= "1110";
                seg <= SEG7_LUT(singles);
                
             when "01" =>
                an  <= "1101";
                seg <= SEG7_LUT(tens);
                
             when "10" =>
                an  <= "1011";
                seg <= SEG7_LUT(hundreds);
                
             when others =>
                an  <= "0111";
                seg <= SEG7_LUT(thousands);
        end case;
    end process;
end arch;