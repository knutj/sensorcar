library ieee;
use ieee.std_logic_1164.all;

package constants_pkg is
    constant AL_DATA_WIDTH  : integer := 8;
    constant DM_ADDR_WIDTH  : integer := 8;
    constant DM_DATA_WIDTH  : integer := 8;
    constant DR_ADDR_WIDTH  : integer := 3;
    constant DR_DATA_WIDTH  : integer := 8;
    constant IM_ADDR_WIDTH  : integer := 5;
    constant IM_DATA_WIDTH  : integer := 24;
    constant OPCODE_WIDTH   : integer := 7;
    constant PC_DATA_WIDTH  : integer := 8;
    constant PWM_WIDTH      : integer := 20;
    constant REG_DATA_WIDTH : integer := 8;
    
    constant LD_Ri_imm:     std_logic_vector(OPCODE_WIDTH - 1 downto 0) := "0000000";
    constant LD_Ri_Rj:      std_logic_vector(OPCODE_WIDTH - 1 downto 0) := "0000001";
    constant LD_Ri_X_Rj:    std_logic_vector(OPCODE_WIDTH - 1 downto 0) := "0000010";
    constant ST_Ri_X_Rj:    std_logic_vector(OPCODE_WIDTH - 1 downto 0) := "0000011";
    constant DEC_Ri:        std_logic_vector(OPCODE_WIDTH - 1 downto 0) := "0000100";
    constant INC_Ri:        std_logic_vector(OPCODE_WIDTH - 1 downto 0) := "0000101";
    constant ADD_Ri_Rj_Rk:  std_logic_vector(OPCODE_WIDTH - 1 downto 0) := "0000110";
    constant SUB_Ri_Rj_Rk:  std_logic_vector(OPCODE_WIDTH - 1 downto 0) := "0000111";
    constant ORR_Ri_Rj_Rk:  std_logic_vector(OPCODE_WIDTH - 1 downto 0) := "0001000";
    constant ORI_Ri_Rj_imm: std_logic_vector(OPCODE_WIDTH - 1 downto 0) := "0001001";
    constant ANR_Ri_Rj_Rk:  std_logic_vector(OPCODE_WIDTH - 1 downto 0) := "0001010";
    constant ANI_Ri_Rj_imm: std_logic_vector(OPCODE_WIDTH - 1 downto 0) := "0001011";
    constant JRZ_Ri_imm:    std_logic_vector(OPCODE_WIDTH - 1 downto 0) := "0001100";
    constant JRNZ_Ri_imm:   std_logic_vector(OPCODE_WIDTH - 1 downto 0) := "0001101";
    constant J_imm:         std_logic_vector(OPCODE_WIDTH - 1 downto 0) := "0001110";
    constant LD_Ri_IN:      std_logic_vector(OPCODE_WIDTH - 1 downto 0) := "0001111";
    constant ST_Ri_OUT:     std_logic_vector(OPCODE_WIDTH - 1 downto 0) := "0010000";
end package constants_pkg;