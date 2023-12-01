library ieee;
use ieee.std_logic_1164.all;
use work.constants_pkg.all;

entity reg_dr is
    port ( 
        clk     : in    std_logic;
        rst     : in    std_logic;
        reg_ld  : in    std_logic;
        reg_d   : in    std_logic_vector(DR_DATA_WIDTH - 1 downto 0);
        reg_q   : out   std_logic_vector(DR_DATA_WIDTH - 1 downto 0)
    );
end reg_dr;

architecture arch of reg_dr is
begin
    process (clk, rst)
    begin
        if rst = '1' then
            reg_q <= (others => '0');
        elsif rising_edge(clk) and reg_ld = '1' then
            reg_q <= reg_d;
        end if;
    end process;
end arch;