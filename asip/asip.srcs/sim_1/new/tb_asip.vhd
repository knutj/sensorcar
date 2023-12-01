library ieee;
use ieee.std_logic_1164.all;
use work.constants_pkg.all;
use work.tb_procedures_pkg.all;

entity tb_asip is
end tb_asip;

architecture arch of tb_asip is 
    component top_asip
    port (
        clk     :   in std_logic;
        rst     :   in std_logic;
        pwm_in  :   in std_logic;
        dig_in  :   in std_logic_vector(DR_DATA_WIDTH - 1 downto 0);
        dig_out :   out std_logic_vector(DR_DATA_WIDTH - 1 downto 0) 
    );
    END component;
    
    -- Inputs
    signal clk      : std_logic;
    signal rst      : std_logic;
    signal pwm_in   : std_logic;
    signal dig_in   : std_logic_vector(DR_DATA_WIDTH - 1 downto 0);
   
    -- Outputs
    signal dig_out   : std_logic_vector(DR_DATA_WIDTH - 1 downto 0);
   
    -- Clock period
    constant clk_period : time := 10 ns;
begin
    -- Unit Under Test (UUT)
    uut : top_asip port map (
        clk => clk,
        rst => rst, 
        pwm_in => pwm_in,
        dig_in => dig_in,
        dig_out => dig_out
    );

   -- Clock process
   clk_process : process
   begin
		clk <= '0';
		wait for clk_period / 2;
		clk <= '1';
		wait for clk_period / 2;
   end process;
 
   -- Stimulus process
   stim_proc: process
   begin		
      rst <= '1';
      wait for clk_period;	
	  rst <= '0';
	  dig_in <= "01010101";
	  wait for clk_period * 64;
	  
	  pwm_loop(pwm_in, clk_period, 0, 1, 10000, 90000);
	  pwm_loop(pwm_in, clk_period, 0, 1,  1000, 99000);
   end process;
end;