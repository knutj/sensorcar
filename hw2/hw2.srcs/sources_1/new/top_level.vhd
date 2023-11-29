-- Listing 6.3 modified
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
 
entity pwm_reader is
   port(clk, rst, write, pwm_in: in std_logic;
        threshold_limit: in std_logic_vector(19 downto 0);
        over_the_limit: inout std_logic;
        width_count: out std_logic_vector(19 downto 0);
        -- Ports for MotorControl
        -- motor_stop: in std_logic; -- Signal to stop motors
        motor_pwm_out: out std_logic; -- PWM output for motor speed control
        motor_dir_A, motor_dir_B: out std_logic_vector(1 downto 0) -- Motor direction control);
        );
end pwm_reader;

architecture arch of pwm_reader is
   signal top_clr, top_cnt, top_ld: std_logic;
   signal top_ucq, top_hrq, top_trq: std_logic_vector(19 downto 0);
   signal motor_stop_signal: std_logic;
   
  
   
       -- Instantiate MotorControl
   component MotorControl
       port(
           stop: in std_logic;
           clk: in std_logic;
           reset: in std_logic;
           pwm_out: out std_logic;
           motor_dir_A, motor_dir_B: out std_logic_vector(1 downto 0)
       );
   end component;

   
begin
    -- instantiate up counter
    counter: entity work.up_counter(arch)
    port map(clk=>clk, rst=>rst, uc_clr=>top_clr, 
             uc_cnt=>top_cnt, uc_q=>top_ucq);
   
    -- instantiate hold register
    hold_reg: entity work.reg(arch)
    port map(clk=>clk, rst=>rst,
		     reg_ld=>top_ld, reg_d=>top_ucq,
		     reg_q=>top_hrq);
	
	-- instantiate threshold register
    threshold_reg: entity work.reg(arch)
    port map(clk=>clk, rst=>rst,
		     reg_ld=>write, reg_d=>threshold_limit,             
		     reg_q=>top_trq);
               
    -- comparator circuit
    over_the_limit <= '0' when top_trq > top_hrq else '1';
	
	-- instantiate FSM control path
    control_path: entity work.fsm(arch)
    port map(clk=>clk, rst=>rst, pwm_in=>pwm_in, 
		     clear=>top_clr, count=>top_cnt, load=>top_ld);
	
	-- width measurement output
	width_count <= top_hrq;
	
	-- Motor control logic
    motor_stop_signal <= '1' when over_the_limit = '0' else '0';

    -- Instantiate MotorControl component
    motor_control_inst: entity work. MotorControl(arch)
        port map(
            stop => motor_stop_signal,
            clk => clk,
            reset => rst,
            pwm_out => motor_pwm_out,
            motor_dir_A => motor_dir_A,
            motor_dir_B => motor_dir_B
        );
	
end arch;