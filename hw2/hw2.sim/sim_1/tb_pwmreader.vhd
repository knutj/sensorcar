library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top_level_tb is
    -- Testbench has no ports
end entity top_level_tb;

architecture behavior of top_level_tb is
    -- Component Declaration for the Unit Under Test (UUT)
    component top_level
        port(
            clk             : in  std_logic;
            rst             : in  std_logic;
            write           : in  std_logic;
            pwm_in          : in  std_logic;
            threshold_limit : in  std_logic_vector(19 downto 0);
            over_the_limit  : out std_logic;
            width_count     : out std_logic_vector(19 downto 0);
            sensor_trig     : out std_logic;
            sensor_echo     : in  std_logic;
            distance : inout integer;
            motor_pwm_out   : out std_logic;
            motor_dir_A     : out std_logic_vector(1 downto 0);
            motor_dir_B     : out std_logic_vector(1 downto 0)
        );
    end component;

    -- Inputs
    signal clk             : std_logic := '0';
    signal rst             : std_logic := '0';
    signal write           : std_logic := '0';
    signal pwm_in          : std_logic := '0';
    signal threshold_limit : std_logic_vector(19 downto 0) := (others => '0');
    signal sensor_echo     : std_logic := '0';

    -- Outputs
    signal over_the_limit  : std_logic;
    signal width_count     : std_logic_vector(19 downto 0);
    signal sensor_trig     : std_logic;
    signal distance : integer;
    signal motor_pwm_out   : std_logic;
    signal motor_dir_A     : std_logic_vector(1 downto 0);
    signal motor_dir_B     : std_logic_vector(1 downto 0);

    -- Clock period definitions
    constant clk_period : time := 10 ns;

begin
    -- Instantiate the Unit Under Test (UUT)
    uut: top_level
        port map(
            clk             => clk,
            rst             => rst,
            write           => write,
            pwm_in          => pwm_in,
            threshold_limit => threshold_limit,
            over_the_limit  => over_the_limit,
            width_count     => width_count,
            sensor_trig     => sensor_trig,
            sensor_echo     => sensor_echo,
            distance    =>     distance,
            motor_pwm_out   => motor_pwm_out,
            motor_dir_A     => motor_dir_A,
            motor_dir_B     => motor_dir_B
        );

    -- Clock process definitions
    clk_process: process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;

    -- Test process
    stim_proc: process
    begin
        -- Initialize Inputs
        rst <= '1';
        wait for 100 ns;
        rst <= '0';

        -- Add stimulus here
        -- Example: Test PWM functionality
        write <= '1';
        threshold_limit <= "10101010101010101010";  -- Example threshold
        pwm_in <= '1';
        wait for 50 ns;
        pwm_in <= '0';
        wait for 50 ns;
        
        -- Example: Test Sensor functionality
        -- Simulate echo signal from sensor
        sensor_echo <= '0';
        wait for 100 ns;
        sensor_echo <= '1';
        wait for 30 ns;  -- Echo duration
        sensor_echo <= '0';

        -- Example: Test Motor Control functionality
        -- ...

        wait; -- Will run indefinitely
    end process;
end architecture;
