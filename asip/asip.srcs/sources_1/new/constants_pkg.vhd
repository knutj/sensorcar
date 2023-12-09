library ieee;
use ieee.std_logic_1164.all;

package constants_pkg is
    constant AL_DATA_WIDTH  : integer := 8;
    constant DIG_DATA_WIDTH : integer := 9;
    constant DM_ADDR_WIDTH  : integer := 8;
    constant DM_DATA_WIDTH  : integer := 8;
    constant DR_ADDR_WIDTH  : integer := 3;
    constant DR_DATA_WIDTH  : integer := 8;
    constant IM_ADDR_WIDTH  : integer := 5;
    constant IM_DATA_WIDTH  : integer := 24;
    constant OPCODE_WIDTH   : integer := 7;
    constant PC_DATA_WIDTH  : integer := 8;
    constant SENSOR_WIDTH   : integer := 20;
    
    -- Display constants
    constant AN_WIDTH           : integer := 4;
    constant SEG_WIDTH          : integer := 8;
    
    -- Segments are represented via 8 bits in the order (dp, g, f, e, d, c, b, a) where each letter is a line in the number on the display
    -- To form a 0, all lines except the middle must be set to 1, and there is no decimal point
    --   --a--
    -- f|     |b
    --   --g--
    -- e|     |c
    --   --d--   dp
    type seven_segment_lookup_table is array(0 to 9) of std_logic_vector(7 downto 0);
    constant SEG7_LUT : seven_segment_lookup_table := (
        "00111111",  -- 0
        "00000110",  -- 1
        "01011011",  -- 2
        "01001111",  -- 3
        "01100110",  -- 4
        "01101101",  -- 5
        "01111101",  -- 6
        "00000111",  -- 7
        "01111111",  -- 8
        "01101111"   -- 9
    ); 

    -- Instructions
    constant LD_Ri_imm      : std_logic_vector(OPCODE_WIDTH - 1 downto 0) := "0000000";
    constant LD_Ri_Rj       : std_logic_vector(OPCODE_WIDTH - 1 downto 0) := "0000001";
    constant LD_Ri_X_Rj     : std_logic_vector(OPCODE_WIDTH - 1 downto 0) := "0000010";
    constant ST_Ri_X_Rj     : std_logic_vector(OPCODE_WIDTH - 1 downto 0) := "0000011";
    constant DEC_Ri         : std_logic_vector(OPCODE_WIDTH - 1 downto 0) := "0000100";
    constant INC_Ri         : std_logic_vector(OPCODE_WIDTH - 1 downto 0) := "0000101";
    constant ADD_Ri_Rj_Rk   : std_logic_vector(OPCODE_WIDTH - 1 downto 0) := "0000110";
    constant SUB_Ri_Rj_Rk   : std_logic_vector(OPCODE_WIDTH - 1 downto 0) := "0000111";
    constant ORR_Ri_Rj_Rk   : std_logic_vector(OPCODE_WIDTH - 1 downto 0) := "0001000";
    constant ORI_Ri_Rj_imm  : std_logic_vector(OPCODE_WIDTH - 1 downto 0) := "0001001";
    constant ANR_Ri_Rj_Rk   : std_logic_vector(OPCODE_WIDTH - 1 downto 0) := "0001010";
    constant ANI_Ri_Rj_imm  : std_logic_vector(OPCODE_WIDTH - 1 downto 0) := "0001011";
    constant JRZ_Ri_imm     : std_logic_vector(OPCODE_WIDTH - 1 downto 0) := "0001100";
    constant JRNZ_Ri_imm    : std_logic_vector(OPCODE_WIDTH - 1 downto 0) := "0001101";
    constant J_imm          : std_logic_vector(OPCODE_WIDTH - 1 downto 0) := "0001110";
    constant LD_Ri_IN       : std_logic_vector(OPCODE_WIDTH - 1 downto 0) := "0001111";
    constant ST_Ri_OUT      : std_logic_vector(OPCODE_WIDTH - 1 downto 0) := "0010000";
    constant ST_Ri_TL       : std_logic_vector(OPCODE_WIDTH - 1 downto 0) := "0010001";
    constant JAL_imm        : std_logic_vector(OPCODE_WIDTH - 1 downto 0) := "0010010";
    constant JBL_imm        : std_logic_vector(OPCODE_WIDTH - 1 downto 0) := "0010011";
    constant TS             : std_logic_vector(OPCODE_WIDTH - 1 downto 0) := "0010100";
    constant JTD_imm        : std_logic_vector(OPCODE_WIDTH - 1 downto 0) := "0010101";
end package constants_pkg;