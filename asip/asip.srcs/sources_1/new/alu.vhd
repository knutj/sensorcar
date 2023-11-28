library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu is
    generic (
        OPCODE_WIDTH : integer := 7;
        ALDATA_WIDTH : integer := 8
    );
    port ( 
        alu_din_hi  : in    STD_LOGIC_VECTOR (ALDATA_WIDTH - 1 downto 0);
        alu_din_lo  : in    STD_LOGIC_VECTOR (ALDATA_WIDTH - 1 downto 0);
        alu_ctr_In  : in    STD_LOGIC_VECTOR (OPCODE_WIDTH - 1 downto 0);
        alu_dout    : out   STD_LOGIC_VECTOR (ALDATA_WIDTH - 1 downto 0);
        alu_zero    : out   STD_LOGIC);
end alu;

architecture arch of alu is
    signal valin_hi : unsigned(ALDATA_WIDTH - 1 downto 0);
    signal valin_lo : unsigned(ALDATA_WIDTH - 1 downto 0);
    signal valout   : unsigned(ALDATA_WIDTH - 1 downto 0);
begin
    valin_hi <= unsigned(alu_din_hi);
    valin_lo <= unsigned(alu_din_lo);
    
    valout <= 
        valin_lo                    when alu_ctr_in="0000000" else
        valin_hi                    when alu_ctr_in="0000001" else
        valin_hi + valin_lo         when alu_ctr_in="0000010" and valin_lo(7)='0' else
        valin_hi - not(valin_lo-1)  when alu_ctr_in="0000010" and valin_lo(7)='1' else 
        valin_hi + valin_lo         when alu_ctr_in="0000011" else                
        valin_hi - 1                when alu_ctr_in="0000100" else
        valin_hi + 1                when alu_ctr_in="0000101" else
        valin_hi + valin_lo         when alu_ctr_in="0000110" else
        valin_hi - valin_lo         when alu_ctr_in="0000111" else
        valin_hi OR valin_lo        when alu_ctr_in="0001000" else
        valin_hi OR valin_lo        when alu_ctr_in="0001001" else 
        valin_hi AND valin_lo       when alu_ctr_in="0001010" else 
        valin_hi AND valin_lo;

    alu_zero <= '1' when valin_hi="0000000" else '0'; 
    alu_dout <= std_logic_vector(valout);
            
end arch;