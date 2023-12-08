-- josemmf@usn.no | 2023.10
-- 8 x 8 RAM with read always enabled
-- triple address bus (2 to read, 1 to write), dual data out bus, single data in bus
-- Modified from XST 8.1i rams_07, adapted from listing 11.1

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Entity declaration for a data register (dreg)
entity dreg is
   -- Generics for setting the address and data width
   generic(
      DRADDR_WIDTH: integer:=3; -- Width of the address bus (number of bits)
      DRDATA_WIDTH: integer:=8  -- Width of the data bus (number of bits)
   );
   port(
      clk: in std_logic; -- Clock signal
      dr_wr_ctr: in std_logic; -- Write control signal (when '1', write operation is enabled)
      dwr_addr, dr1_addr, dr2_addr: in std_logic_vector(DRADDR_WIDTH-1 downto 0); -- Address inputs
      dwr_din: in std_logic_vector(DRDATA_WIDTH-1 downto 0); -- Data input for write operation
      dr1_dout, dr2_dout: out std_logic_vector(DRDATA_WIDTH-1 downto 0) -- Data outputs for read operation
    );
end dreg;

architecture arch of dreg is
   -- Type definition for RAM, to store the data
   type ram_type is array (2**DRADDR_WIDTH-1 downto 0)
        of std_logic_vector (DRDATA_WIDTH-1 downto 0);
   signal ram: ram_type; -- Signal of type ram_type to act as the memory

begin
   -- Process triggered by the rising edge of the clock
   process (clk)
   begin
      if rising_edge(clk) then
         -- Write operation: When dr_wr_ctr is '1', write data to the address specified by dwr_addr
         if (dr_wr_ctr='1') then
            ram(to_integer(unsigned(dwr_addr))) <= dwr_din;
         end if;
      end if;
   end process;

   -- Continuous assignments for reading from the RAM
   -- Read operation: Output the data from the address specified by dr1_addr and dr2_addr
   dr1_dout <= ram(to_integer(unsigned(dr1_addr)));
   dr2_dout <= ram(to_integer(unsigned(dr2_addr)));

end arch;
