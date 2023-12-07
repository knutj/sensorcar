-- josemmf@usn.no | 2023.10
-- Single-port ROM w/ 8-bit addr bus, 24-bit data bus
-- (adapted from) Listing 11.5

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity imem is
   generic(
      IMADDR_WIDTH: integer:=5;
      IMDATA_WIDTH: integer:=24
   );
   port(
      im_addr: in std_logic_vector(IMADDR_WIDTH-1 downto 0);
      im_dout: out std_logic_vector(IMDATA_WIDTH-1 downto 0)
    );
end imem;

architecture arch of imem is
   type rom_type is array (0 to 2**IMADDR_WIDTH-1)
        of std_logic_vector(IMDATA_WIDTH-1 downto 0);
    
   constant instr_opcodes: rom_type:=(  
       x"00E886",  -- addr 04: L1: ADD  R1,R2,R7  # 00000000(imm) 111(rs2=R7) 010(rs1=R2) 001(rd=R1) 0000110
       x"001D01",  -- addr 01:     LD   R2,R7     # 00000000(imm) 000(rs2=  ) 111(rs1=R7) 010(rd=R2) 0000001 
       x"00E010",  -- addr 14:     ST   R7,OUT    # 00000000(imm) 111(rs2=R7) 000(rs1=  ) 000(rd=  ) 0010000
       x"001D01",  -- addr 01:     LD   R2,R7     # 00000000(imm) 000(rs2=  ) 111(rs1=R7) 010(rd=R2) 0000001 
       x"0A5C03",  -- addr 02:     ST   R2,10(R7) # 00001010(imm) 010(rs2=R2) 111(rs1=R7) 000(rd=  ) 0000011
       x"F91C0D",  -- addr 11:     JRNZ R7,L1     # 11111001(imm) 000(rs2=  ) 111(rs1=R7) 000(rd=  ) 0001101
       x"00000E",  -- addr 16:     J    L2        # 00000000(imm) 000(rs2=  ) 000(rs1=  ) 000(rd=  ) 0001110	  
       x"0A5C03",  -- addr 02:     ST   R2,10(R7) # 00001010(imm) 010(rs2=R2) 111(rs1=R7) 000(rd=  ) 0000011
       x"01080C",  -- addr 12:     JRZ  R7,L2     # 00000001(imm) 000(rs2=  ) 010(rs1=R7) 000(rd=  ) 0001100
       x"0A5C03",  -- addr 02:     ST   R2,10(R7) # 00001010(imm) 010(rs2=R2) 111(rs1=R7) 000(rd=  ) 0000011
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
	   x"FFFFFF",  -- addr 28: (void)
	   x"FFFFFF",  -- addr 29: (void)
	   x"FFFFFF",  -- addr 30: (void)
	   x"FFFFFF",  -- addr 28: (void)
	   x"FFFFFF",  -- addr 29: (void)
	   x"FFFFFF",  -- addr 30: (void)
	   x"FFFFFF",  -- addr 30: (void)
	   x"FFFFFF"   -- addr 31: (void)
   );
begin
   im_dout <= instr_opcodes(to_integer(unsigned(im_addr)));
end arch;