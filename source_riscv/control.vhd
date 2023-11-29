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
      alu_ctr: out std_logic_vector(OPCODE_WIDTH-1 downto 0);
      -- PWM Radar control signals
      pwm_start, pwm_stop, pwm_read: out std_logic
   );
end control;

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
   
   -- PWM Radar opcode constants
    constant START_PWM: std_logic_vector(OPCODE_WIDTH-1 downto 0) := "0010001";
    constant STOP_PWM: std_logic_vector(OPCODE_WIDTH-1 downto 0) := "0010010";
    constant READ_PWM: std_logic_vector(OPCODE_WIDTH-1 downto 0) := "0010011";
      
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
	  -- Default PWM radar control signals to '0'
      pwm_start <= '0';
      pwm_stop <= '0';
      pwm_read <= '0';
	  
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
             elsif opcode=LD_Ri_IN then -- LD Ri,IN (load Ri from digital inputs)
                pc_mux_ctr <= '1';    
	            dreg_write <= '1';   
	            in_mux_ctr <= '1';  
	         elsif opcode=ST_Ri_OUT then -- ST Ri,OUT (store Ri into digital outputs)
                pc_mux_ctr <= '1';    
	            out_reg_write <= '1';   
	         end if;
	         if opcode = START_PWM then
                pwm_start <= '1';
             elsif opcode = STOP_PWM then
                pwm_stop <= '1';
             elsif opcode = READ_PWM then
                pwm_read <= '1';
             end if;
      end case;
      
   end process;
   
end arch;
