library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.constants_pkg.all;

entity imem is
    Port ( 
        im_addr     : in    std_logic_vector (IM_ADDR_WIDTH - 1 downto 0);
        im_dout     : out   std_logic_vector (IM_DATA_WIDTH - 1 downto 0));
end imem;

architecture arch of imem is
    type rom_type is array (0 to 2**IM_ADDR_WIDTH - 1) of std_logic_vector(IM_DATA_WIDTH - 1 downto 0);
    
    constant instruction_opcodes : rom_type := (-- # LFLBRFRB -- Engine composiiton LF - Left Forward
    -- Startup:
        x"550080",  -- addr 00:     LD   R1,85     # 01010101(imm) 000(rs2=  ) 000(rs1=  ) 001(rd=R1) 0000000 
        x"AA0101",  -- addr 01:     LD   R2,170    # 10101010(imm) 000(rs2=  ) 000(rs1=  ) 010(rd=R2) 0000001 
        x"A50182",  -- addr 02:     LD   R3,165    # 10100101(imm) 000(rs2=  ) 000(rs1=  ) 011(rd=R3) 0000011
        
    -- Forward loop:
        x"FFFFFF",  -- addr 03:     
        x"FFFFFF",  -- addr 04: 
        x"FFFFFF",  -- addr 05:     
        x"FFFFFF",  -- addr 06:     
        x"FFFFFF",  -- addr 07:     
        x"FFFFFF",  -- addr 08:     
        x"FFFFFF",  -- addr 09:     
        x"FFFFFF",  -- addr 10:     
        x"FFFFFF",  -- addr 11:     
        x"FFFFFF",  -- addr 12:     
        x"FFFFFF",  -- addr 13:
        x"FFFFFF",  -- addr 14:     
        x"FFFFFF",  -- addr 15:     
        x"FFFFFF",  -- addr 16:     	  
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
    
--    constant instruction_opcodes : rom_type := (
--        x"060380",  -- addr 00:     LD   R7,6      # 00000110(imm) 000(rs2=  ) 000(rs1=  ) 111(rd=R7) 0000000 
--        x"001D01",  -- addr 01:     LD   R2,R7     # 00000000(imm) 000(rs2=  ) 111(rs1=R7) 010(rd=R2) 0000001 
--        x"0A5C03",  -- addr 02:     ST   R2,10(R7) # 00001010(imm) 010(rs2=R2) 111(rs1=R7) 000(rd=  ) 0000011
--        x"001F85",  -- addr 03:     INC  R7        # 00000000(imm) 000(rs2=  ) 111(rs1=R7) 111(rd=R7) 0000101
--        x"00E886",  -- addr 04: L1: ADD  R1,R2,R7  # 00000000(imm) 111(rs2=R7) 010(rs1=R2) 001(rd=R1) 0000110
--        x"002487",  -- addr 05:     SUB  R1,R1,R1  # 00000000(imm) 001(rs2=R1) 001(rs1=R1) 001(rd=R1) 0000111
--        x"004888",  -- addr 06:     ORR  R1,R2,R2  # 00000000(imm) 010(rs2=R2) 010(rs1=R2) 001(rd=R1) 0001000
--        x"FF0489",  -- addr 07:     ORI  R1,R1,xFF # 11111111(imm) 000(rs2=  ) 001(rs1=R1) 001(rd=R1) 0001001
--        x"00448A",  -- addr 08:     ANR  R1,R1,R2  # 00000000(imm) 010(rs2=R2) 001(rs1=R1) 001(rd=R1) 0001010
--        x"00088B",  -- addr 09:     ANI  R1,R2,x00 # 00000000(imm) 000(rs2=  ) 010(rs1=R2) 001(rd=R1) 0001011
--        x"001F84",  -- addr 10:     DEC  R7        # 00000000(imm) 000(rs2=  ) 111(rs1=R7) 111(rd=R7) 0000100
--        x"F91C0D",  -- addr 11:     JRNZ R7,L1     # 11111001(imm) 000(rs2=  ) 111(rs1=R7) 000(rd=  ) 0001101
--        x"01080C",  -- addr 12:     JRZ  R7,L2     # 00000001(imm) 000(rs2=  ) 010(rs1=R7) 000(rd=  ) 0001100
--        x"0A0B82",  -- addr 13: L2: LD   R7,10(R2) # 00001010(imm) 000(rs2=  ) 010(rs1=R2) 111(rd=R7) 0000010
--        x"00E010",  -- addr 14:     ST   R7,OUT    # 00000000(imm) 111(rs2=R7) 000(rs1=  ) 000(rd=  ) 0010000
--        x"00038F",  -- addr 15:     LD   R7,IN     # 00000000(imm) 000(rs2=  ) 000(rs1=  ) 111(rd=R7) 0001111
--        x"00000E",  -- addr 16:     J    L2        # 00000000(imm) 000(rs2=  ) 000(rs1=  ) 000(rd=  ) 0001110	  
--        x"FFFFFF",  -- addr 17: (void)
--        x"FFFFFF",  -- addr 18: (void)
--        x"FFFFFF",  -- addr 19: (void)
--        x"FFFFFF",  -- addr 20: (void)
--        x"FFFFFF",  -- addr 21: (void)
--        x"FFFFFF",  -- addr 22: (void)
--        x"FFFFFF",  -- addr 23: (void)
--        x"FFFFFF",  -- addr 24: (void)
--        x"FFFFFF",  -- addr 25: (void)
--        x"FFFFFF",  -- addr 26: (void)
--        x"FFFFFF",  -- addr 27: (void)
--        x"FFFFFF",  -- addr 28: (void)
--        x"FFFFFF",  -- addr 29: (void)
--        x"FFFFFF",  -- addr 30: (void)
--        x"FFFFFF"   -- addr 31: (void)
--    );

begin
    im_dout <= instruction_opcodes(to_integer(unsigned(im_addr)));
end arch;