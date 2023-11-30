library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.constants_pkg.all;

entity alu is
    port ( 
        alu_din_hi  : in    STD_LOGIC_VECTOR (AL_DATA_WIDTH - 1 downto 0);
        alu_din_lo  : in    STD_LOGIC_VECTOR (AL_DATA_WIDTH - 1 downto 0);
        alu_ctr_In  : in    STD_LOGIC_VECTOR (OPCODE_WIDTH - 1 downto 0);
        alu_dout    : out   STD_LOGIC_VECTOR (AL_DATA_WIDTH - 1 downto 0);
        alu_zero    : out   STD_LOGIC);
end alu;

architecture arch of alu is
    signal valin_hi : unsigned(AL_DATA_WIDTH - 1 downto 0);
    signal valin_lo : unsigned(AL_DATA_WIDTH - 1 downto 0);
    signal valout   : unsigned(AL_DATA_WIDTH - 1 downto 0);
begin
    valin_hi <= unsigned(alu_din_hi);
    valin_lo <= unsigned(alu_din_lo);
    
    valout <= 
        valin_lo                    when alu_ctr_in=LD_Ri_imm else
        valin_hi                    when alu_ctr_in=LD_Ri_Rj else
        valin_hi + valin_lo         when alu_ctr_in=LD_Ri_X_Rj and valin_lo(7)='0' else
        valin_hi - not(valin_lo-1)  when alu_ctr_in=LD_Ri_X_Rj and valin_lo(7)='1' else 
        valin_hi + valin_lo         when alu_ctr_in=ST_Ri_X_Rj else                
        valin_hi - 1                when alu_ctr_in=DEC_Ri else
        valin_hi + 1                when alu_ctr_in=INC_Ri else
        valin_hi + valin_lo         when alu_ctr_in=ADD_Ri_Rj_Rk else
        valin_hi - valin_lo         when alu_ctr_in=SUB_Ri_Rj_Rk else
        valin_hi OR valin_lo        when alu_ctr_in=ORR_Ri_Rj_Rk else
        valin_hi OR valin_lo        when alu_ctr_in=ORI_Ri_Rj_imm else 
        valin_hi AND valin_lo       when alu_ctr_in=ANR_Ri_Rj_Rk else 
        valin_hi AND valin_lo;

    alu_zero <= '1' when valin_hi="0000000" else '0'; 
    alu_dout <= std_logic_vector(valout);
            
end arch;