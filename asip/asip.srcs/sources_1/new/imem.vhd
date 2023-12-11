library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.constants_pkg.all;

entity imem is
    Port ( 
        im_addr     : in    std_logic_vector (IM_ADDR_WIDTH - 1 downto 0);
        im_dout     : out   std_logic_vector (IM_DATA_WIDTH - 1 downto 0));
end imem;

-- Regarding register 4 and 5 below
-- Threshold limit is a concatenation between 12 0 bits and the immediate value to create 20 bits, where an immediate of 1 would equal 4096
-- Choosing 20 cm as minimum and 50 cm as maximum, for forward and backward limits respectively
-- The equation is range = (time * speed) / 2, where time is the time for echo in high and speed is 340m/s = 34,000cm/s = 0.034cm/us = 0.000034cm/ns
-- Time is calculated using the up counter, and its counts on each rising clock, which means it counts every 20ns (As the clock high is 10ns)
-- Time = 2 * range / speed = 2 * 20 cm / 0.000034 cm/ns = 1,176,470 ns => divided by 20 gives about 58,823
-- 1110 0000 0000 0000 is equal to 57,344, close to the value above, therefore the immediate of R4 is set to 1110

architecture arch of imem is
    type rom_type is array (0 to 2**IM_ADDR_WIDTH - 1) of std_logic_vector(IM_DATA_WIDTH - 1 downto 0);
    
    constant instruction_opcodes : rom_type := (--  # LFLBRFRB -- Motor composition LF - Left Forward
    -- Load registers
        x"550080",  -- addr 00:     LD  R1,85   # 01010101(imm) 000(rs2=  ) 000(rs1=  ) 001(rd=R1) 0000000      -- R1: Forward
        x"AA0100",  -- addr 01:     LD  R2,170  # 10101010(imm) 000(rs2=  ) 000(rs1=  ) 010(rd=R2) 0000000      -- R2: Backward
        x"A50180",  -- addr 02:     LD  R3,165  # 10100101(imm) 000(rs2=  ) 000(rs1=  ) 011(rd=R3) 0000000      -- R3: Turn left
        x"0E0200",  -- addr 03:     LD  R4,14   # 00001110(imm) 000(rs2=  ) 000(rs1=  ) 100(rd=R4) 0000000      -- R4: MIN threshold for forward
        x"230280",  -- addr 04:     LD  R5,35   # 00100011(imm) 000(rs2=  ) 000(rs1=  ) 101(rd=R5) 0000000      -- R5: MAX threshold for Backward
    -- Forward threshold and loop
        x"008011",  -- addr 05: T1: ST  R4,TL   # 00000000(imm) 100(rs2=R4) 000(rs1=  ) 000(rd=  ) 0010001      -- T1: Store MIN threshold in threshold register
        x"030012",  -- addr 06: L1: JAL T2      # 00000011(imm) 000(rs2=  ) 000(rs1=  ) 000(rd=  ) 0010010      -- L1: Jump to T2 if above limit
        x"002010",  -- addr 07:     ST  R1,OUT  # 00000000(imm) 001(rs2=R1) 000(rs1=  ) 000(rd=  ) 0010000      -- Send R1 out via dr2_dout -> dig_out
        x"FE000E",  -- addr 08:     J   L1      # 11111110(imm) 000(rs2=  ) 000(rs1=  ) 000(rd=  ) 0001110      -- Jump to L1 to restart loop
    -- Backward threshold and loop
        x"00A011",  -- addr 09: T2: ST  R5,TL   # 00000000(imm) 101(rs2=R5) 000(rs1=  ) 000(rd=  ) 0010001      -- T2: Store MAX threshold in threshold register
        x"030013",  -- addr 10: L2: JBL T3      # 00000011(imm) 000(rs2=  ) 000(rs1=  ) 000(rd=  ) 0010011      -- L2: Jump to T3 if below limit
        x"004010",  -- addr 11:     ST  R2,OUT  # 00000000(imm) 010(rs2=R2) 000(rs1=  ) 000(rd=  ) 0010000      -- Send R2 out via dr2_dout -> dig_out
        x"FE000E",  -- addr 12:     J   L2      # 11111110(imm) 000(rs2=  ) 000(rs1=  ) 000(rd=  ) 0001110      -- Jump to L2 to restart loop
    -- Turn left loop
        x"000014",  -- addr 13: T3: TS          # 00000000(imm) 000(rs2=  ) 000(rs1=  ) 000(rd=  ) 0010100      -- T3: Timer start
        x"F70015",  -- addr 14: L3: JTD T1      # 11110111(imm) 000(rs2=  ) 000(rs1=  ) 000(rd=  ) 0010101      -- L3: Jump to T1 if timer is done
        x"006010",  -- addr 15:     ST  R3,OUT  # 00000000(imm) 011(rs2=R3) 000(rs1=  ) 000(rd=  ) 0010000      -- Send R3 out via dr2_dout -> dig_out
        x"FE000E",  -- addr 16:     J   L3      # 11111110(imm) 000(rs2=  ) 000(rs1=  ) 000(rd=  ) 0001110      -- Jump to L3 to restart loop
    -- Unused instructions
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
    im_dout <= instruction_opcodes(to_integer(unsigned(im_addr)));
end arch;