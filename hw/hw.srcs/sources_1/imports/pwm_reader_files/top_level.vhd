-- Listing 6.3 modified
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pwm_reader is
   port(clk, rst, write, pwm_in: in std_logic;
        threshold_limit: in std_logic_vector(19 downto 0);
        over_the_limit: out std_logic;
        width_count: out std_logic_vector(19 downto 0));
end pwm_reader;

architecture arch of pwm_reader is
   signal top_clr, top_cnt, top_ld: std_logic;
   signal top_ucq, top_hrq, top_trq: std_logic_vector(19 downto 0);

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
	
end arch;