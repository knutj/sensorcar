-- josemmf@usn.no | 2023.10
-- Listing 4.5 modified

library ieee;
use ieee.std_logic_1164.all;  -- Importing the standard logic package

-- Define an entity named 'pc', representing a Program Counter
entity pc is
   -- Define a generic parameter to specify the width of the program counter
   generic(
      PCDATA_WIDTH: integer := 8  -- Width of the program counter (8 bits by default)
   );
   -- Define input and output ports
   port(
      clk, rst: in std_logic;  -- Clock (clk) and reset (rst) signals
      reg_d: in std_logic_vector(PCDATA_WIDTH-1 downto 0);  -- Data input for the program counter
      reg_q: out std_logic_vector(PCDATA_WIDTH-1 downto 0)  -- Output of the program counter
    );
end pc;

-- Architecture of the program counter
architecture arch of pc is
begin
   -- Process sensitive to clock and reset
   process(clk, rst)
   begin
      -- Reset condition
      if (rst = '1') then
         reg_q <= (others => '0');  -- Set the program counter to all zeros
      -- Clock edge condition
      elsif rising_edge(clk) then
         reg_q <= reg_d;  -- Update the program counter with the input data on the rising edge of the clock
      end if;
   end process;
end arch;
