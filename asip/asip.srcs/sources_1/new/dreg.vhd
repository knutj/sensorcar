library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.constants.all;

entity dreg is
    port ( 
        clk         : in    std_logic;
        dr_wr_ctr   : in    std_logic;
        dwr_addr    : in    std_logic_vector(DR_ADDR_WIDTH - 1 downto 0);
        dr1_addr    : in    std_logic_vector(DR_ADDR_WIDTH - 1 downto 0);
        dr2_addr    : in    std_logic_vector(DR_ADDR_WIDTH - 1 downto 0);
        dwr_din     : in    std_logic_vector(DR_DATA_WIDTH - 1 downto 0);
        dr1_dout    : out   std_logic_vector(DR_DATA_WIDTH - 1 downto 0);
        dr2_dout    : out   std_logic_vector(DR_DATA_WIDTH - 1 downto 0)
    );
end dreg;

architecture arch of dreg is
    type ram_type is array (2**DR_ADDR_WIDTH - 1 downto 0) of std_logic_vector(DR_DATA_WIDTH - 1 downto 0);
    signal ram : ram_type;
    
begin
    process (clk)
    begin
        if rising_edge(clk) and dr_wr_ctr = '1' then
            ram(to_integer(unsigned(dwr_addr))) <= dwr_din;
        end if;
    end process;
    
    dr1_dout <= ram(to_integer(unsigned(dr1_addr)));
    dr2_dout <= ram(to_integer(unsigned(dr2_addr)));
    
end arch;
