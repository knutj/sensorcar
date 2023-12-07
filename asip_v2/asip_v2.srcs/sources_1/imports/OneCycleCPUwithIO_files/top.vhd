-- josemmf@usn.no | 2023.10
-- Listing 6.3 modified

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.constants_pkg.all;

entity OneCycleCPUwithIO is
   generic(
      PCDATA_WIDTH: integer:=8;    -- Width of the program counter (PC) data. Determines the size of PC.
      IMADDR_WIDTH: integer:=5;    -- Width of the instruction memory address. Determines the addressing range for instruction memory.
      IMDATA_WIDTH: integer:=24;   -- Width of the instruction memory data. Determines the size of instructions.
      DRADDR_WIDTH: integer:=3;    -- Width of the data register address. Determines the addressing range for data registers.
      DRDATA_WIDTH: integer:=8;    -- Width of the data register data. Determines the size of data held in data registers.
      DMADDR_WIDTH: integer:=8;    -- Width of the data memory address. Determines the addressing range for data memory.
      DMDATA_WIDTH: integer:=8;    -- Width of the data memory data. Determines the size of data held in data memory.
      OPCODE_WIDTH: integer:=7;    -- Width of the operation code (opcode). Determines the size of opcodes used in instructions.
      ECHO_COUNTER: integer := 500;-- Value for echo signal counter, possibly for sensor interfacing.
      BACK_COUNTER: integer := 1000000; -- Counter value for backward movement in a motor control application.
      TURN_COUNTER: integer := 500000; -- Counter value for turning in a motor control application.
      THRESHOLD   : std_logic_vector(THRESHOLD_WIDTH - 1 downto 0) := "10000000" -- Threshold value, possibly for sensor or motor control logic.    
   );
     -- Generic parameters for the entity (omitted for brevity)
   port(
      clk     : in std_logic;    -- Clock signal: Synchronizes the operation of the CPU.
      rst     : in std_logic;    -- Reset signal: Initializes or resets the CPU when asserted.
      dig_in  : in std_logic_vector(DRDATA_WIDTH-1 downto 0); -- Digital input: Used for reading external data into the CPU.
      trig    : out std_logic;   -- Trigger signal: Used for triggering external devices or operations, like a sensor.
      echo    : in std_logic;    -- Echo signal: Used for receiving input from external devices like sensors.
      dig_out : out std_logic_vector(DRDATA_WIDTH-1 downto 0); -- Digital output: Used for sending data from the CPU to external devices.
      m_dig_out : out std_logic_vector(DRDATA_WIDTH-1 downto 0) -- Motor digital output: Controls motor operations or sends signals to motor drivers.
   );
end OneCycleCPUwithIO;

architecture arch of OneCycleCPUwithIO is
   -- Control signals for writing to data registers and data memory.
    signal dr_wr_ctr, dm_wr_ctr: std_logic;
    
    -- Control signal indicating when the ALU result is zero.
    signal alu_zero: std_logic;
    
    -- Control signals for multiplexers in the design.
    signal pc_mux_ctr, alu_mux_ctr, dreg_mux_ctr: std_logic;
    
    -- Program Counter (PC) input and output signals. pc_in is the next value for PC, pc_out is the current value.
    signal pc_in, pc_out: std_logic_vector(PCDATA_WIDTH-1 downto 0);
    
    -- Output signal from Instruction Memory (IM), containing the current opcode.
    signal opcd_out: std_logic_vector(IMDATA_WIDTH-1 downto 0);
    
    -- Output signals from data registers. dr1_dout and dr2_dout hold the data read from the registers.
    signal dr1_dout, dr2_dout: std_logic_vector(DRDATA_WIDTH-1 downto 0);
    
    -- Output of the ALU multiplexer and the ALU itself.
    signal alu_mux_out: std_logic_vector(DRDATA_WIDTH-1 downto 0); -- Input to ALU selected by mux
    signal alu_dout: std_logic_vector(DRDATA_WIDTH-1 downto 0);    -- Output from ALU
    
    -- Output from Data Memory (DM) and the data register multiplexer.
    signal dm_dout: std_logic_vector(DMDATA_WIDTH-1 downto 0);     -- Data read from DM
    signal dr_mux_out: std_logic_vector(DMDATA_WIDTH-1 downto 0);  -- Output of data register mux
    
    -- Control input to the ALU, determining the operation to perform.
    signal alu_ctr_in: std_logic_vector(OPCODE_WIDTH-1 downto 0);
    
    -- Control signals for input multiplexer and output register write enable.
    signal in_mux_ctr, out_reg_wr: std_logic;
    
    -- Output of the input multiplexer, determining the data to write into a register.
    signal in_mux_out: std_logic_vector(DRDATA_WIDTH-1 downto 0);
    
    -- Signal to start the echo sensor measurement.
    signal start_echo: std_logic;
    
    -- Motor control signals, each bit representing a control signal for a motor.
    signal motors: std_logic_vector(7 downto 0);

    
    -- Motor timers
    signal start_bw     : std_logic;
    signal timeup_bw    : std_logic;
    signal start_tl     : std_logic;
    signal timeup_tl    : std_logic;
    
    signal top_clr      : std_logic;
    signal top_cnt      : std_logic;
    signal top_ld       : std_logic;
    signal top_ucq      : std_logic_vector(8 - 1 downto 0);
    signal top_hrq      : std_logic_vector(8 - 1 downto 0);
    signal top_trq      : std_logic_vector(8 - 1 downto 0);
    signal above_limit  : std_logic;
    signal motor_start  : std_logic;

begin

    motor : entity work.motor(arch)
    port map (
        clk         => clk,
        rst         => rst,
        echo        => echo,
        above_limit => above_limit,
        timeup_bw   => timeup_bw,
        timeup_tl   => timeup_tl,
        clr         => top_clr,
        cnt         => top_cnt,
        ld          => top_ld,
        motors      => motors,
        start_bw    => start_bw,
        start_tl    => start_tl,
        start_motor => motor_start
    );

    backward_timer : entity work.timer(arch)
    generic map (LIMIT => BACK_COUNTER)
    port map (
        clk         => clk,
        rst         => rst,
        start       => start_bw,
        timer_q     => timeup_bw
    );
    
    turnleft_timer : entity work.timer(arch)
    generic map (LIMIT => TURN_COUNTER)
    port map (
        clk         => clk,
        rst         => rst,
        start       => start_tl,
        timer_q     => timeup_tl
    );

    up_counter : entity work.up_counter(arch) 
    port map ( clk => clk,
               rst => rst,
               uc_clr      => top_clr,
               uc_cnt      => top_cnt,
               uc_q        => top_ucq
    
    );

    hold_reg : entity work.reg(arch)
    port map (
        clk         => clk,
        rst         => rst,
        reg_ld      => top_ld,
        reg_d       => top_ucq,
        reg_q       => top_hrq
    );
    
    threshold_reg : entity work.reg(arch)
    port map (
        clk         => clk,
        rst         => rst,
        reg_ld      => '1',
        reg_d       => THRESHOLD,
        reg_q       => top_trq
    );


    motor_reg : entity work.reg(arch)
    port map (
        clk         => clk,
        rst         => rst,
        reg_ld      => '1',
        reg_d       => motors,
        reg_q       => m_dig_out
    );


    echo_timer : entity work.timer(arch)
    generic map (
        LIMIT       => ECHO_COUNTER,
        MODE        => '0'
    )
     port map (
        clk         => clk,
        rst         => rst,
        start       => start_echo,
        timer_q     => trig
    );
    

    -- instantiate program counter
    pc: entity work.pc(arch)
    port map(clk=>clk, rst=>rst, reg_d=>pc_in, 
             reg_q=>pc_out);
   
    -- instantiate instruction memory
    imem: entity work.imem(arch)
    port map(im_addr=>pc_out(4 downto 0), im_dout=>opcd_out);
	
	-- instantiate data registers
    dreg: entity work.dreg(arch)
    port map(clk=>clk, dr_wr_ctr=>dr_wr_ctr, dwr_addr=>opcd_out(9 downto 7), 
		     dr1_addr=>opcd_out(12 downto 10), dr2_addr=>opcd_out(15 downto 13),              
		     dwr_din=>in_mux_out, dr1_dout=>dr1_dout, dr2_dout=>dr2_dout);
	
	-- instantiate ALU
    alu: entity work.alu(arch)
    port map(alu_din_hi=>dr1_dout, alu_din_lo=>alu_mux_out,             
		     alu_ctr_in=>alu_ctr_in, alu_dout=>alu_dout, alu_zero=>alu_zero);
	
	-- instantiate data memory
    dmem: entity work.dmem(arch)
    port map(clk=>clk, dm_wr_ctr=>dm_wr_ctr, 
		     dm_addr=>alu_dout, dm_din=>dr2_dout, dm_dout=>dm_dout);              
		                       
	-- instantiate FSM control path
    control: entity work.control(arch)
    port map(clk=>clk, rst=>rst, alu_zero=>alu_zero, 
		     pc_mux_ctr=>pc_mux_ctr, alu_mux_ctr=>alu_mux_ctr, dreg_mux_ctr=>dreg_mux_ctr, in_mux_ctr=>in_mux_ctr, out_reg_write=>out_reg_wr,
		     opcode=>opcd_out(OPCODE_WIDTH-1 downto 0), dreg_write=>dr_wr_ctr, dmem_write=>dm_wr_ctr, alu_ctr=>alu_ctr_in,echo_start=>start_echo,start_motor=>motor_start);
		     
    -- instantiate output register
    out_reg: entity work.reg(arch)
    port map(clk=>clk, rst=>rst, reg_ld=>out_reg_wr, 
             reg_d=>dr2_dout, reg_q=>dig_out);
    
	
	-- Glue logic at top level: pc_mux
	pc_in <= std_logic_vector(unsigned(pc_out) + 1) when pc_mux_ctr='1' else 
	         std_logic_vector(unsigned(pc_out) + unsigned(opcd_out(23 downto 16))) when opcd_out(23)='0' else
             std_logic_vector(unsigned(pc_out) - not(unsigned(opcd_out(23 downto 16))-1))  ;
             
	-- Glue logic at top level: alu_mux
	alu_mux_out <= opcd_out(23 downto 16) when alu_mux_ctr='1' else dr2_dout;     

	-- Glue logic at top level: dr_mux
	dr_mux_out <= alu_dout when dreg_mux_ctr='1' else dm_dout;  
	
	-- Glue logic at top level: in_mux
	in_mux_out <= dig_in when in_mux_ctr='1' else dr_mux_out;  

	 -- Comparator
    above_limit <= '0' when top_trq > top_hrq or rst = '1' else '1';
		
end arch;