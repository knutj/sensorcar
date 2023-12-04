library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity limit_checker_tb is
    -- Testbench has no ports!
end limit_checker_tb;

architecture behavior of limit_checker_tb is 
    -- Component Declaration for the Unit Under Test (UUT)
    component limit_checker
        Port ( clk             : in  std_logic;
               reset           : in  std_logic;
               threshold_limit : in  std_logic_vector(19 downto 0);
               write_limit     : in  std_logic;
               PWM_in          : in  std_logic_vector(19 downto 0);
               above_limit     : in  std_logic;  -- Changed to 'in'
               pwm_out         : out std_logic); -- Added output port
    end component;

    --Inputs
    signal clk             : std_logic := '0';
    signal reset           : std_logic := '0';
    signal threshold_limit : std_logic_vector(19 downto 0) := (others => '0');
    signal write_limit     : std_logic := '0';
    signal PWM_in          : std_logic_vector(19 downto 0) := (others => '0');
    signal above_limit     : std_logic := '0';  -- Added signal for above_limit

    --Outputs
    signal pwm_out         : std_logic;  -- Added signal for pwm_out

    -- Clock period definitions
    constant clk_period : time := 10 ns;

begin 
    -- Instantiate the Unit Under Test (UUT)
    uut: limit_checker Port Map (
          clk => clk,
          reset => reset,
          threshold_limit => threshold_limit,
          write_limit => write_limit,
          PWM_in => PWM_in,
          above_limit => above_limit,  -- Connected
          pwm_out => pwm_out          -- Connected
        );

    -- Clock process definitions
    clk_process :process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;

    -- Testbench stimulus process
    stim_proc: process
    variable i : integer;
    begin		
        reset <= '1';
        wait for clk_period;	
        reset <= '0';
        threshold_limit <= "00000000000000001111"; -- Example value
        write_limit <= '1';
        wait for clk_period;
        write_limit <= '0';
        for i in 0 to 3 loop
            PWM_in <= "00000000000000001111"; -- Example value
            wait for clk_period*5000;
            PWM_in <= (others => '0');
            wait for clk_period*95000;
        end loop;
        threshold_limit <= "00000000000000111111"; -- Example value
        write_limit <= '1';
        wait for clk_period;
        write_limit <= '0';	
        for i in 0 to 3 loop
            PWM_in <= "00000000000000001111"; -- Example value
            wait for clk_period*5000;
            PWM_in <= (others => '0');
            wait for clk_period*95000;
        end loop;        
        for i in 0 to 3 loop
            PWM_in <= "00000000000000001111"; -- Example value
            wait for clk_period*30000;
            PWM_in <= (others => '0');
            wait for clk_period*70000;
        end loop;
    end process;
end behavior;

