-- Import standard logic definitions from the IEEE library
library ieee;
use ieee.std_logic_1164.all;

-- Define a new entity named 'reg' for a digital register
entity reg is
   -- Generic parameter to define the data width of the register
   generic(
      DRDATA_WIDTH: integer := 8 -- The width of the data (default 8 bits)
   );
   -- Define the input and output ports for the entity
   port(
      clk: in std_logic;               -- Clock input signal
      rst: in std_logic;               -- Reset input signal
      reg_ld: in std_logic;            -- Load input signal (loads data when high)
      reg_d: in std_logic_vector(DRDATA_WIDTH-1 downto 0); -- Data input (vector)
      reg_q: out std_logic_vector(DRDATA_WIDTH-1 downto 0) -- Data output (vector)
    );
end reg;

-- Architecture definition of the 'reg' entity
architecture arch of reg is

begin
   -- Define a sequential process triggered by changes in 'clk' and 'rst'
   process(clk, rst)
   begin
      -- If reset is high ('1'), then clear the register
      if (rst = '1') then
         reg_q <= (others => '0'); -- Set all bits of the register to zero
      -- If a rising edge on the clock signal is detected
      elsif rising_edge(clk) then
         -- If load signal is high ('1'), load the data from 'reg_d' into the register
         if (reg_ld = '1') then
            reg_q <= reg_d; -- Transfer data from input 'reg_d' to output 'reg_q'
         end if;
      end if;
   end process;
   
end arch;
