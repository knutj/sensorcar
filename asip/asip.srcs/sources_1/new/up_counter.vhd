library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.constants_pkg.all;

entity up_counter is
    port (
        clk     : in    std_logic;
        rst     : in    std_logic;
        uc_clr  : in    std_logic;
        uc_cnt  : in    std_logic;
        uc_q    : out   std_logic_vector(PWM_WIDTH - 1 downto 0)
    );
end up_counter;

architecture arch of up_counter is
    signal r_reg : unsigned(PWM_WIDTH - 1 downto 0);
    signal r_next: unsigned(PWM_WIDTH - 1 downto 0);
begin
    process (clk, rst)
    begin
        if rst = '1' then
            r_reg <= (others => '0');
        elsif rising_edge(clk) then
            r_reg <= r_next;
        end if;
    end process;

    r_next <=
        r_reg + 1       when uc_cnt = '1' else
        (others => '0') when uc_clr = '1' else
        r_reg;
    
    uc_q <= std_logic_vector(r_reg);
    
end arch;