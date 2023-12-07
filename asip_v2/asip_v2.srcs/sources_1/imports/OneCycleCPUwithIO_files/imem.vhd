library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Entity declaration for an Instruction Memory (imem)
entity imem is
   -- Generics for setting the address and data width
   generic(
      IMADDR_WIDTH: integer := 5; -- Width of the address bus (number of bits)
      IMDATA_WIDTH: integer := 24 -- Width of the data bus (number of bits)
   );
   port(
      im_addr: in std_logic_vector(IMADDR_WIDTH-1 downto 0); -- Address input
      im_dout: out std_logic_vector(IMDATA_WIDTH-1 downto 0) -- Data output
    );
end imem;

architecture arch of imem is
   -- Type definition for ROM, to store the instructions
   type rom_type is array (0 to 2**IMADDR_WIDTH-1)
        of std_logic_vector(IMDATA_WIDTH-1 downto 0);
    
   -- Constant array of opcodes for the instruction memory
   constant instr_opcodes: rom_type := (
      -- Instructions are stored in a ROM (Read-Only Memory)
      -- Each entry corresponds to an address in the ROM
      -- These instructions are represented in hexadecimal format
      -- addr 00 to 31: Representing 32 instructions (or void spaces) in the memory
      -- Main:
      --- x"000041", -- addr 07: New instruction check_if_echo with opcode 1000001
      x"000020", -- addr 01: New instruction with opcode 0100000
      x"000040", -- addr 02: New instruction with opcode 1000000
	  x"FFFFFF",  -- addr 03: (void)
	  x"FFFFFF",  -- addr 04: (void)
	  x"FFFFFF",  -- addr 05: (void)
	  x"FFFFFF",  -- addr 06: (void)
	  x"FFFFFF",  -- addr 07: (void)
	  x"FFFFFF",  -- addr 08: (void)
	  x"FFFFFF",  -- addr 09: (void)
	  x"FFFFFF",  -- addr 10: (void)
	  x"FFFFFF",  -- addr 11: (void)
	  x"FFFFFF",  -- addr 12: (void)
	  x"FFFFFF",  -- addr 13: (void)
	  x"FFFFFF",  -- addr 14: (void)
	  x"FFFFFF",  -- addr 15: (void)
	  x"FFFFFF",  -- addr 16: (void)
	  x"FFFFFF",   -- addr 17: (void) 
	  x"FFFFFF",  -- addr 18: (void)
	  x"FFFFFF",  -- addr 19: (void)
	  x"FFFFFF",  -- addr 20: (void)
	  x"FFFFFF",  -- addr 21: (void)
	  x"FFFFFF",  -- addr 22: (void)
	  x"FFFFFF",  -- addr 23: (void)
	  x"FFFFFF",  -- addr 24: (void)
	  x"FFFFFF",  -- addr 25: (void)
	  x"FFFFFF",  -- addr 26: (void)
	  x"FFFFFF",  -- addr 27: (void)
	  x"FFFFFF",  -- addr 28: (void)
	  x"FFFFFF",  -- addr 29: (void)
	  x"FFFFFF",  -- addr 20: (void)
	  x"FFFFFF",  -- addr 30: (void)
	  x"FFFFFF"   -- addr 31: (void) 
   );

begin
   -- Output the instruction based on the address input
   -- The ROM array 'instr_opcodes' is indexed by the address to output the corresponding instruction
   im_dout <= instr_opcodes(to_integer(unsigned(im_addr)));
end arch;
