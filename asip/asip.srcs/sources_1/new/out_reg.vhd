library ieee;
use ieee.std_logic_1164.ALL;

entity out_reg is
    generic (
        DATA_WIDTH : integer := 8
    ); 
    port ( 
        clk         : in    std_logic;
        rst         : in    std_logic;
        reg_ld      : in    std_logic;
        reg_din     : in    std_logic_vector(DATA_WIDTH - 1 downto 0);
        reg_dout    : out   std_logic_vector(DATA_WIDTH - 1 downto 0)
    );
end out_reg;

architecture arch of out_reg is
begin
    process (clk, rst)
    begin
        if rst = '1' then
            reg_dout <= (others => '0');
        elsif rising_edge(clk) and reg_ld = '1' then
            reg_dout <= reg_din;
        end if;
    end process;
end arch;