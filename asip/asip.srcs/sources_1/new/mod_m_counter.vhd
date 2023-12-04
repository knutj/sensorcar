library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;
use work.constants_pkg.all;

entity mod_m_counter is
    generic (
        N : integer := 9;  -- Number of bits (E.g. 2^N > M)
        M : integer := 326 -- Modulus M
    );
    port (
        clk         : in    std_logic;
        rst         : in    std_logic;
        max_tick    : out   std_logic;
        mc_q        : out   std_logic_vector(N - 1 downto 0)
    );
end mod_m_counter;

architecture arch of mod_m_counter is
    signal r_reg    : unsigned(N - 1 downto 0);
    signal r_next   : unsigned(N - 1 downto 0);
begin
    process (clk, rst)
    begin
        if rst = '1' then
            r_reg <= (others => '0');
        elsif clk'event and clk = '1' then
            r_reg <= r_next;
        end if;
    end process;

    r_next      <= r_reg + 1    when r_reg < (M - 1) else (others => '0');
    max_tick    <= '0'          when r_reg < (M - 1) else '1';
    mc_q        <= std_logic_vector(r_reg);
    
end arch;
