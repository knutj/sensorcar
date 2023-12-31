library ieee;
use ieee.std_logic_1164.all;
use work.constants_pkg.all;

entity control_asip is
    port ( 
        clk             : in    std_logic;
        rst             : in    std_logic;
        alu_zero        : in    std_logic;
        opcode          : in    std_logic_vector(OPCODE_WIDTH - 1 downto 0);
        above_limit     : in    std_logic;
        timer_done      : in    std_logic;

        pc_mux_ctr      : out   std_logic;
        in_mux_ctr      : out   std_logic;
        dreg_write      : out   std_logic;
        alu_mux_ctr     : out   std_logic;
        alu_ctr         : out   std_logic_vector(OPCODE_WIDTH - 1 downto 0);
        dreg_mux_ctr    : out   std_logic;
        dmem_write      : out   std_logic;
        out_reg_write   : out   std_logic;
        write_limit     : out   std_logic;
        timer_start     : out   std_logic
    );
end control_asip;

architecture arch of control_asip is
begin
    process (opcode, alu_zero)
    begin
        pc_mux_ctr      <= '0';
        in_mux_ctr      <= '0';
        dreg_write      <= '0';
        alu_mux_ctr     <= '0';
        alu_ctr         <= opcode;
        dreg_mux_ctr    <= '0';
        dmem_write      <= '0';
        out_reg_write   <= '0';
        write_limit     <= '0';
        timer_start     <= '0';
        
        if opcode = LD_Ri_imm then          -- LD Ri,<imm> (load Ri with an immediate value)
            pc_mux_ctr <= '1';    
            dreg_write <= '1'; 
            alu_mux_ctr <= '1';  
            dreg_mux_ctr <= '1';
            
        elsif opcode = LD_Ri_Rj then        -- LD Ri,Rj (copy the value of Rj into Ri)
            pc_mux_ctr <= '1';    
            dreg_write <= '1';   
            dreg_mux_ctr <= '1';  
            
        elsif opcode = LD_Ri_X_Rj then      -- LD Ri,X(Rj) (load Ri from data memory)
            pc_mux_ctr <= '1';    
            dreg_write <= '1'; 
            alu_mux_ctr <= '1';  
            
        elsif opcode = ST_Ri_X_Rj then      -- ST Ri,X(Rj) (store Ri into data memory)
            pc_mux_ctr <= '1';    
            alu_mux_ctr <= '1';  
            dmem_write <= '1';
            
        elsif opcode = DEC_Ri then          -- DEC Ri (decrement Ri)
            pc_mux_ctr <= '1';    
            dreg_write <= '1';  
            dreg_mux_ctr <= '1';  
            
        elsif opcode = INC_Ri then          -- INC Ri (increment Ri)
            pc_mux_ctr <= '1';    
            dreg_write <= '1';  
            dreg_mux_ctr <= '1';
            
        elsif opcode = ADD_Ri_Rj_Rk then    -- ADD Ri,Rj,Rk (Ri = Rj + Rk))
            pc_mux_ctr <= '1';    
            dreg_write <= '1';   
            dreg_mux_ctr <= '1';  
            
        elsif opcode = SUB_Ri_Rj_Rk then    -- SUB Ri,Rj,Rk (Ri = Rj - Rk))
            pc_mux_ctr <= '1';    
            dreg_write <= '1';   
            dreg_mux_ctr <= '1';
            
        elsif opcode = ORR_Ri_Rj_Rk then    -- ORR Ri,Rj,Rk (Ri = Rj OR Rk)
            pc_mux_ctr <= '1';    
            dreg_write <= '1';   
            dreg_mux_ctr <= '1';  
            
        elsif opcode = ORI_Ri_Rj_imm then   -- ORI Ri,Rj,<imm> (Ri = Rj OR <imm>)
            pc_mux_ctr <= '1';    
            dreg_write <= '1'; 
            alu_mux_ctr <= '1';  
            dreg_mux_ctr <= '1';  
            
        elsif opcode = ANR_Ri_Rj_Rk then    -- ANR Ri,Rj,Rk (Ri = Rj AND Rk)
            pc_mux_ctr <= '1';    
            dreg_write <= '1';   
            dreg_mux_ctr <= '1';
            
        elsif opcode = ANI_Ri_Rj_imm then   -- ANI Ri,Rj,<imm> (Ri = Rj AND <imm>)
            pc_mux_ctr <= '1';    
            dreg_write <= '1'; 
            alu_mux_ctr <= '1';  
            dreg_mux_ctr <= '1';
            
        elsif opcode = JRZ_Ri_imm then      -- JRZ Ri,<imm> (jump if Ri is zero)
            pc_mux_ctr <= not(alu_zero);  
              
        elsif opcode = JRNZ_Ri_imm then     -- JRNZ Ri,<imm> (jump if Ri is not zero)
            pc_mux_ctr <= alu_zero; 
               
        elsif opcode = J_imm then           -- J <imm> (unconditional jump)
            -- Not necessary to do anything since pc_mux_ctr = '0' by default, resulting in a jump
            
        elsif opcode = LD_Ri_IN then        -- LD Ri,IN (load Ri from digital inputs)
            pc_mux_ctr <= '1';    
            dreg_write <= '1';   
            in_mux_ctr <= '1';  
            
        elsif opcode = ST_Ri_OUT then       -- ST Ri,OUT (store Ri into digital outputs)
            pc_mux_ctr <= '1';    
            out_reg_write <= '1';
            
        elsif opcode = ST_Ri_TL then        -- ST Ri,TL (store Ri into threshold limit)
            pc_mux_ctr <= '1';
            write_limit <= '1';
            
        elsif opcode = JAL_imm then         -- JAL <imm> (jump if above limit)
            pc_mux_ctr <= not(above_limit);
            
        elsif opcode = JBL_imm then         -- JBL <imm> (jump if below limit)
            pc_mux_ctr <= above_limit;
            
        elsif opcode = TS then              -- TS (timer start)
            pc_mux_ctr <= '1';
            timer_start <= '1';
            
        elsif opcode = JTD_imm then         -- JTD <imm> (jump if timer done)
            pc_mux_ctr <= not(timer_done);
            
         end if;
    end process;
end arch;



















