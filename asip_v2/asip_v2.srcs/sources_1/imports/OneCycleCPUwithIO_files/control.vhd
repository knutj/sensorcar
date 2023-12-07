-- josemmf@usn.no | 2023.10

library ieee;
use ieee.std_logic_1164.all;
entity control is
   generic(
      OPCODE_WIDTH: integer:=7
   );
   port(
      clk, rst: in std_logic;
      alu_zero: in std_logic;
      opcode: in std_logic_vector(OPCODE_WIDTH-1 downto 0);
      pc_mux_ctr, dreg_write, alu_mux_ctr, dreg_mux_ctr, dmem_write: out std_logic;
      in_mux_ctr, out_reg_write: out std_logic;
      echo_start : out std_logic;
      start_motor : out std_logic;
      alu_ctr: out std_logic_vector(OPCODE_WIDTH-1 downto 0)
   );
end control;
--clk: Clock signal. Used to synchronize the operations of the digital system or processor.

--rst: Reset signal. Used to initialize or reset the state of the system to a known starting condition.

--alu_zero: ALU Zero flag. Typically an output from an Arithmetic Logic Unit (ALU), indicating that the result of the last operation was zero.

--opcode: Opcode signal. Represents the operation code, which is a binary value instructing the processor which operation to perform.

--pc_mux_ctr: Program Counter MUX Control. A control signal that likely determines the source of the next program counter value, e.g., whether to jump to a new location or continue to the next sequential address.

--dreg_write: Data Register Write control. A control signal that enables writing to a data register.

--alu_mux_ctr: ALU MUX Control. A control signal for a multiplexer that selects one of the inputs to the ALU.

--dreg_mux_ctr: Data Register MUX Control. A control signal for a multiplexer that selects the data to be written into a data register.

--dmem_write: Data Memory Write control. A control signal that enables writing to data memory.

--in_mux_ctr: Input MUX Control. A control signal for a multiplexer that selects between different input sources.

--out_reg_write: Output Register Write control. A control signal that enables writing to an output register.

--echo_start: Echo Start. This might be a control signal to start an echo operation, possibly related to measuring distance or time in a system like an ultrasonic sensor.

--alu_ctr: ALU Control. A set of control signals for the ALU that determines which operation it should perform (e.g., add, subtract, AND, OR).

architecture arch of control is
-- constant declaration for instruction opcodes:
   constant LD_Ri_imm:     std_logic_vector(OPCODE_WIDTH-1 downto 0) :="0000000";
   constant LD_Ri_Rj:      std_logic_vector(OPCODE_WIDTH-1 downto 0) :="0000001";
   constant LD_Ri_X_Rj:    std_logic_vector(OPCODE_WIDTH-1 downto 0) :="0000010";
   constant ST_Ri_X_Rj:    std_logic_vector(OPCODE_WIDTH-1 downto 0) :="0000011";
   constant DEC_Ri:        std_logic_vector(OPCODE_WIDTH-1 downto 0) :="0000100";
   constant INC_Ri:        std_logic_vector(OPCODE_WIDTH-1 downto 0) :="0000101";
   constant ADD_Ri_Rj_Rk:  std_logic_vector(OPCODE_WIDTH-1 downto 0) :="0000110";
   constant SUB_Ri_Rj_Rk:  std_logic_vector(OPCODE_WIDTH-1 downto 0) :="0000111";
   constant ORR_Ri_Rj_Rk:  std_logic_vector(OPCODE_WIDTH-1 downto 0) :="0001000";
   constant ORI_Ri_Rj_imm: std_logic_vector(OPCODE_WIDTH-1 downto 0) :="0001001";
   constant ANR_Ri_Rj_Rk:  std_logic_vector(OPCODE_WIDTH-1 downto 0) :="0001010";
   constant ANI_Ri_Rj_imm: std_logic_vector(OPCODE_WIDTH-1 downto 0) :="0001011";
   constant JRZ_Ri_imm:    std_logic_vector(OPCODE_WIDTH-1 downto 0) :="0001100";
   constant JRNZ_Ri_imm:   std_logic_vector(OPCODE_WIDTH-1 downto 0) :="0001101";
   constant J_imm:         std_logic_vector(OPCODE_WIDTH-1 downto 0) :="0001110";
   constant LD_Ri_IN:      std_logic_vector(OPCODE_WIDTH-1 downto 0) :="0001111";
   constant ST_Ri_OUT:     std_logic_vector(OPCODE_WIDTH-1 downto 0) :="0010000";
   constant start_echo:    std_logic_vector(OPCODE_WIDTH-1 downto 0) :="0100000";
   constant start_m:       std_logic_vector(OPCODE_WIDTH-1 downto 0) :="1000000";
-- LD_Ri_imm: Load immediate value into register Ri.
--LD_Ri_Rj: Load the value from register Rj into register Ri.
--LD_Ri_X_Rj: Load the value from memory at address specified by the contents of Rj into register Ri.
--ST_Ri_X_Rj: Store the value from register Ri into memory at the address specified by the contents of Rj.
--DEC_Ri: Decrement the value in register Ri.
--INC_Ri: Increment the value in register Ri.
--ADD_Ri_Rj_Rk: Add the values in registers Rj and Rk, and store the result in register Ri.
--SUB_Ri_Rj_Rk: Subtract the value in Rk from Rj and store the result in Ri.
--ORR_Ri_Rj_Rk: Perform bitwise OR on values in Rj and Rk, and store the result in Ri.
--ORI_Ri_Rj_imm: Perform bitwise OR on the value in Rj and an immediate value, and store the result in Ri.
--ANR_Ri_Rj_Rk: Perform bitwise AND on values in Rj and Rk, and store the result in Ri.
--ANI_Ri_Rj_imm: Perform bitwise AND on the value in Rj and an immediate value, and store the result in Ri.
--JRZ_Ri_imm: Jump to the address specified by an immediate value if the value in Ri is zero.
--JRNZ_Ri_imm: Jump to the address specified by an immediate value if the value in Ri is not zero.
--J_imm: Unconditional jump to the address specified by an immediate value.
--LD_Ri_IN: Load a value from an input device into register Ri.
--ST_Ri_OUT: Store the value from register Ri to an output device.
   
      
   type state_type is (s0);
   signal st_reg, st_next: state_type;
   
begin
   -- state register
   process(clk,rst)
   begin
      if (rst='1') then
         st_reg <= s0;
      elsif rising_edge(clk) then
         st_reg <= st_next;
      end if;
   end process;
   
   -- next-state/output logic
   process(opcode, alu_zero)
   begin
      st_next <= st_reg;  -- default back to same state
      pc_mux_ctr <= '0';    
	  dreg_write <= '0'; 
      alu_mux_ctr <= '0';  
	  dreg_mux_ctr <= '0';  
	  dmem_write <= '0';
	  in_mux_ctr <= '0'; 
	  out_reg_write <= '0';
	  alu_ctr <= opcode;
	  
      case st_reg is
         when s0 =>
            if opcode=LD_Ri_imm then -- LD Ri,<imm> (load Ri with an immediate value)
                pc_mux_ctr <= '1';    
	            dreg_write <= '1'; 
                alu_mux_ctr <= '1';  
	            dreg_mux_ctr <= '1';
	         elsif opcode=LD_Ri_Rj then -- LD Ri,Rj (copy the value of Rj into Ri)
                pc_mux_ctr <= '1';    
	            dreg_write <= '1';   
	            dreg_mux_ctr <= '1';  
	         elsif opcode=LD_Ri_X_Rj then -- LD Ri,X(Rj) (load Ri from data memory)
                pc_mux_ctr <= '1';    
	            dreg_write <= '1'; 
                alu_mux_ctr <= '1';  
	         elsif opcode=ST_Ri_X_Rj then -- ST Ri,X(Rj) (store Ri into data memory)
                pc_mux_ctr <= '1';    
                alu_mux_ctr <= '1';  
	            dmem_write <= '1';
	         elsif opcode=DEC_Ri then -- DEC Ri (decrement Ri)
                pc_mux_ctr <= '1';    
	            dreg_write <= '1';  
	            dreg_mux_ctr <= '1';  
	         elsif opcode=INC_Ri then -- INC Ri (increment Ri)
                pc_mux_ctr <= '1';    
	            dreg_write <= '1';  
	            dreg_mux_ctr <= '1';
	         elsif opcode=ADD_Ri_Rj_Rk then -- ADD Ri,Rj,Rk (Ri = Rj + Rk))
                pc_mux_ctr <= '1';    
	            dreg_write <= '1';   
	            dreg_mux_ctr <= '1';  
	         elsif opcode=SUB_Ri_Rj_Rk then -- SUB Ri,Rj,Rk (Ri = Rj - Rk))
                pc_mux_ctr <= '1';    
	            dreg_write <= '1';   
	            dreg_mux_ctr <= '1';
	         elsif opcode=ORR_Ri_Rj_Rk then -- ORR Ri,Rj,Rk (Ri = Rj OR Rk)
                pc_mux_ctr <= '1';    
	            dreg_write <= '1';   
 	            dreg_mux_ctr <= '1';  
	         elsif opcode=ORI_Ri_Rj_imm then -- ORI Ri,Rj,<imm> (Ri = Rj OR <imm>)
                pc_mux_ctr <= '1';    
	            dreg_write <= '1'; 
                alu_mux_ctr <= '1';  
	            dreg_mux_ctr <= '1';  
	         elsif opcode=ANR_Ri_Rj_Rk then -- ANR Ri,Rj,Rk (Ri = Rj AND Rk)
                pc_mux_ctr <= '1';    
	            dreg_write <= '1';   
	            dreg_mux_ctr <= '1';
	         elsif opcode=ANI_Ri_Rj_imm then -- ANI Ri,Rj,<imm> (Ri = Rj AND <imm>)
                pc_mux_ctr <= '1';    
	            dreg_write <= '1'; 
                alu_mux_ctr <= '1';  
	            dreg_mux_ctr <= '1';
	         elsif opcode=JRZ_Ri_imm then -- JRZ Ri,<imm> (jump if Ri is zero)
                pc_mux_ctr <= not(alu_zero);    
	         elsif opcode=JRNZ_Ri_imm then -- JRNZ Ri,<imm> (jump if Ri is not zero)
                pc_mux_ctr <= alu_zero;    
             elsif opcode=J_imm then -- J <imm> (unconditional jump)
                -- no signals to activate in this case
                echo_start <= '1';
                start_motor <= '1';
             elsif opcode=LD_Ri_IN then -- LD Ri,IN (load Ri from digital inputs)
                pc_mux_ctr <= '1';    
	            dreg_write <= '1';   
	            in_mux_ctr <= '1';  
	         elsif opcode=ST_Ri_OUT then -- ST Ri,OUT (store Ri into digital outputs)
                pc_mux_ctr <= '1';    
	            out_reg_write <= '1';   
	         elsif opcode=start_echo then
	               echo_start <='1' ;
	         elsif opcode=start_m then
	              start_motor <= '1';
	         end if;
      end case;
      
   end process;
   
end arch;
