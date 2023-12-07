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
     x"060380",  -- addr 00:     LD   R7,6      # 00000110(imm) 000(rs2=  ) 000(rs1=  ) 111(rd=R7) 0000000 
      x"001D01",  -- addr 01:     LD   R2,R7     # 00000000(imm) 000(rs2=  ) 111(rs1=R7) 010(rd=R2) 0000001 
	  x"0A5C03",  -- addr 02:     ST   R2,10(R7) # 00001010(imm) 010(rs2=R2) 111(rs1=R7) 000(rd=  ) 0000011
	  x"001F85",  -- addr 03:     INC  R7        # 00000000(imm) 000(rs2=  ) 111(rs1=R7) 111(rd=R7) 0000101
	  x"00E886",  -- addr 04: L1: ADD  R1,R2,R7  # 00000000(imm) 111(rs2=R7) 010(rs1=R2) 001(rd=R1) 0000110
	  x"002487",  -- addr 05:     SUB  R1,R1,R1  # 00000000(imm) 001(rs2=R1) 001(rs1=R1) 001(rd=R1) 0000111
	  x"004888",  -- addr 06:     ORR  R1,R2,R2  # 00000000(imm) 010(rs2=R2) 010(rs1=R2) 001(rd=R1) 0001000
	  x"FF0489",  -- addr 07:     ORI  R1,R1,xFF # 11111111(imm) 000(rs2=  ) 001(rs1=R1) 001(rd=R1) 0001001
	  x"00448A",  -- addr 08:     ANR  R1,R1,R2  # 00000000(imm) 010(rs2=R2) 001(rs1=R1) 001(rd=R1) 0001010
	  x"00088B",  -- addr 09:     ANI  R1,R2,x00 # 00000000(imm) 000(rs2=  ) 010(rs1=R2) 001(rd=R1) 0001011
	  x"001F84",  -- addr 10:     DEC  R7        # 00000000(imm) 000(rs2=  ) 111(rs1=R7) 111(rd=R7) 0000100
	  x"F91C0D",  -- addr 11:     JRNZ R7,L1     # 11111001(imm) 000(rs2=  ) 111(rs1=R7) 000(rd=  ) 0001101
	  x"01080C",  -- addr 12:     JRZ  R7,L2     # 00000001(imm) 000(rs2=  ) 010(rs1=R7) 000(rd=  ) 0001100
	  x"0A0B82",  -- addr 13: L2: LD   R7,10(R2) # 00001010(imm) 000(rs2=  ) 010(rs1=R2) 111(rd=R7) 0000010
	  x"00E010",  -- addr 14:     ST   R7,OUT    # 00000000(imm) 111(rs2=R7) 000(rs1=  ) 000(rd=  ) 0010000
	  x"00038F",  -- addr 15:     LD   R7,IN     # 00000000(imm) 000(rs2=  ) 000(rs1=  ) 111(rd=R7) 0001111
	  x"00000E",  -- addr 16:     J    L2        # 00000000(imm) 000(rs2=  ) 000(rs1=  ) 000(rd=  ) 0001110	
	  x"FFFFFF",  -- addr 17: (void)
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
	  x"FFFFFF",  -- addr 30: (void)
	  x"FFFFFF"   -- addr 31: (void) 
   );

begin
   -- Output the instruction based on the address input
   -- The ROM array 'instr_opcodes' is indexed by the address to output the corresponding instruction
   im_dout <= instr_opcodes(to_integer(unsigned(im_addr)));
end arch;
