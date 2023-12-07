-- josemmf@usn.no | 2023.10
-- Listing 4.5 modified
library ieee;
use ieee.std_logic_1164.all;  -- Standard logic types
use ieee.numeric_std.all;     -- Numeric standard library for arithmetic operations

--An ALU (Arithmetic Logic Unit) is a fundamental building block of a CPU (Central Processing Unit) in a computer. 
--It is responsible for performing arithmetic operations (like addition, subtraction) and logic operations (like AND, OR, NOT) on binary numbers.


-- Define an entity named 'alu'
entity alu is
   -- Generic parameters to define opcode width and data width of the ALU
   generic(
      OPCODE_WIDTH: integer := 7;  -- Width of the opcode (7 bits)
      ALUDATA_WIDTH: integer := 8  -- Width of the ALU data (8 bits)
   );
   -- Define input and output ports
   port(
      alu_din_hi, alu_din_lo: in std_logic_vector(ALUDATA_WIDTH-1 downto 0); -- High and low data inputs
      alu_ctr_in: in std_logic_vector(OPCODE_WIDTH-1 downto 0);              -- Control input (opcode)
      alu_dout: out std_logic_vector(ALUDATA_WIDTH-1 downto 0);             -- Data output
      alu_zero: out std_logic                                               -- Zero flag output
    );
end alu;

-- Architecture of the ALU entity
architecture arch of alu is
   -- Internal signals for arithmetic operations
   signal valin_hi, valin_lo, valout: unsigned (ALUDATA_WIDTH-1 downto 0);

begin
   -- Convert std_logic_vector inputs to unsigned values
   valin_hi <= unsigned(alu_din_hi);
   valin_lo <= unsigned(alu_din_lo);

   -- ALU operations determined by the opcode (alu_ctr_in)
   -- Each line corresponds to an operation based on the opcode value
   valout <= valin_lo when alu_ctr_in = "0000000" else  -- LD Ri,<imm>
             valin_hi when alu_ctr_in = "0000001" else  -- LD Ri,Rj
             (valin_hi + valin_lo) when (alu_ctr_in = "0000010" and valin_lo(7) = '0') else
             (valin_hi - not(valin_lo - 1)) when (alu_ctr_in = "0000010" and valin_lo(7) = '1') else -- LD Ri,X(Rj)
             -- Additional operations follow the same pattern
             (valin_hi + valin_lo) when alu_ctr_in = "0000011" else  -- ST Ri,X(Rj)
             (valin_hi - 1) when alu_ctr_in = "0000100" else         -- DEC Ri
             (valin_hi + 1) when alu_ctr_in = "0000101" else         -- INC Ri
             (valin_hi + valin_lo) when alu_ctr_in = "0000110" else  -- ADD Ri,Rj,Rk
             (valin_hi - valin_lo) when alu_ctr_in = "0000111" else  -- SUB Ri,Rj,Rk
             (valin_hi OR valin_lo) when alu_ctr_in = "0001000" else -- ORR Ri,Rj,Rk
             (valin_hi OR valin_lo) when alu_ctr_in = "0001001" else -- ORI Ri,<imm>
             (valin_hi AND valin_lo) when alu_ctr_in = "0001010" else -- ANR Ri,Rj,Rk
             (valin_hi AND valin_lo);                                -- ANI Ri,<imm>

   -- Zero flag output: Set to '1' if result is zero, else set to '0'
   alu_zero <= '1' when valin_hi = "0000000" else '0';

   -- Convert the result to std_logic_vector format for the output
   alu_dout <= std_logic_vector(valout);

end arch;
