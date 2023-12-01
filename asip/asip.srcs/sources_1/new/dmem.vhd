library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity dmem is
    generic (
        DM_ADDR_WIDTH : integer := 8;
        DM_DATA_WIDTH : integer := 8
    );
    port ( 
        clk         : in    std_logic;
        dm_wr_ctr   : in    std_logic;
        dm_addr     : in    std_logic_vector(DM_ADDR_WIDTH - 1 downto 0);
        dm_din      : in    std_logic_vector(DM_DATA_WIDTH - 1 downto 0);
        dm_dout     : out   std_logic_vector(DM_DATA_WIDTH - 1 downto 0)
    );
end dmem;

architecture arch of dmem is
    type ram_type is array (2**DM_ADDR_WIDTH - 1 downto 0) of std_logic_vector(DM_DATA_WIDTH - 1 downto 0);
    signal ram : ram_type;
begin
    process (clk)
    begin
        if rising_edge(clk) and dm_wr_ctr = '1' then
            ram(to_integer(unsigned(dm_addr))) <= dm_din;
        end if;
    end process;
    
    dm_dout <= ram(to_integer(unsigned(dm_addr)));
    
end arch;
