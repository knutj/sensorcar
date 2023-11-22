--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY tb_pwm_reader IS
END tb_pwm_reader;
 
ARCHITECTURE behavior OF tb_pwm_reader IS 
 
    -- Component Declaration for the Unit Under Test (UUT) 
    COMPONENT pwm_reader
    PORT(clk, rst, write, pwm_in: in std_logic;
        threshold_limit: in std_logic_vector(19 downto 0);
        over_the_limit: out std_logic;
        width_count: out std_logic_vector(19 downto 0));
    END COMPONENT;
    
   --Inputs
   signal clk : std_logic;
   signal rst : std_logic;
   signal write : std_logic;
   signal pwm_in : std_logic;
   signal threshold_limit : std_logic_vector(19 downto 0);
 	--Outputs
   signal over_the_limit : std_logic;
   signal width_count : std_logic_vector(19 downto 0);
   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: pwm_reader PORT MAP (
          clk => clk,
          rst => rst,
          threshold_limit => threshold_limit,
          write => write,
          pwm_in => pwm_in,
          width_count => width_count,
          over_the_limit => over_the_limit );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      rst <= '1';
      wait for clk_period;	
	  rst <= '0';
      threshold_limit <= "00000000111100001111"; -- 3855
      write <= '1';
      wait for clk_period;
      write <= '0';
      for i in 0 to 3 loop
         pwm_in <= '1';
	     wait for clk_period*5000;
	     pwm_in <= '0';
	     wait for clk_period*95000;
	  end loop;
      threshold_limit <= "00000001111100001111"; -- 7951
      write <= '1';
      wait for clk_period;
      write <= '0';	
      for i in 0 to 3 loop
         pwm_in <= '1';
	     wait for clk_period*5000;
	     pwm_in <= '0';
	     wait for clk_period*95000;
	  end loop;        
      for i in 0 to 3 loop
         pwm_in <= '1';
	     wait for clk_period*30000;
	     pwm_in <= '0';
	     wait for clk_period*70000;
	  end loop;
   end process;

END;
