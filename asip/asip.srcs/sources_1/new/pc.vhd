library ieee;
use ieee.std_logic_1164.all;

entity pc is
    generic (
        DATA_WIDTH : integer := 8
    );
    port (
        clk         : in    std_logic;
        rst         : in    std_logic;
        pc_din      : in    std_logic_vector(DATA_WIDTH - 1 downto 0);
        pc_dout     : out   std_logic_vector(DATA_WIDTH - 1 downto 0)
    );
end pc;

architecture arch of pc is
begin
    process (clk, rst)
    begin
        if rst = '1' then
            pc_dout <= (others => '0');
        elsif rising_edge(clk) then
            pc_dout <= pc_din;
        end if;
    end process;
end arch;