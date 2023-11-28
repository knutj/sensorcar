library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;  -- If using unsigned types

entity tb_pwm_reader_sensor is
    -- Testbench has no ports
end entity tb_pwm_reader_sensor;

architecture behavior of tb_pwm_reader_sensor is
    -- Component Declaration for the PWM Reader
    component pwm_reader
        port(
            clk, rst, write, pwm_in: in std_logic;
            threshold_limit: in std_logic_vector(19 downto 0);
            over_the_limit: out std_logic;
            width_count: out std_logic_vector(19 downto 0)
        );
    end component;

    -- Component Declaration for the Sensor
    component sensor
        port(
            clk         : in  std_logic;
            reset       : in  std_logic;
            trig_pulse  : in  std_logic;
            echo        : in  std_logic;
            trig        : out std_logic;
            distance    : out unsigned(15 downto 0)
        );
    end component;

    -- Inputs
    signal clk             : std_logic := '0';
    signal rst             : std_logic;
    signal write           : std_logic;
    signal pwm_in          : std_logic;
    signal threshold_limit : std_logic_vector(19 downto 0);
    signal trig_pulse      : std_logic;
    signal echo            : std_logic;

    -- Outputs
    signal over_the_limit  : std_logic;
    signal width_count     : std_logic_vector(19 downto 0);
    signal trig            : std_logic;
    signal distance        : unsigned(15 downto 0);

    -- Clock period definition
    constant clk_period : time := 10 ns;

begin
    -- Instantiate the PWM Reader
    uut_pwm_reader: pwm_reader
        port map (
            clk => clk,
            rst => rst,
            write => write,
            pwm_in => pwm_in,
            threshold_limit => threshold_limit,
            over_the_limit => over_the_limit,
            width_count => width_count
        );

    -- Instantiate the Sensor
    uut_sensor: sensor
        port map (
            clk => clk,
            reset => rst,
            trig_pulse => trig_pulse,
            echo => echo,
            trig => trig,
            distance => distance
        );

    -- Clock process definitions
    clk_process: process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;

    -- Stimulus process
    stim_proc: process
    begin		
        -- Initialize Inputs for PWM Reader
        rst <= '1';
        threshold_limit <= "00000000111100001111"; -- 3855
        write <= '1';
        wait for clk_period;
        rst <= '0';
        write <= '0';
        -- Test PWM Reader behavior
        -- Add your tests here
        -- ...

        -- Initialize Inputs for Sensor
        rst <= '1';
        trig_pulse <= '0';
        echo <= '0';
        wait for 100 ns;  -- Wait for system reset
        rst <= '0';

        -- Test Sensor behavior
        -- Simulate sensor trigger and echo for different distances
        -- Example: Simulate an object at a close distance
        trig_pulse <= '1';
        wait for 10 us;  -- Trigger pulse duration
        trig_pulse <= '0';
        echo <= '1';
        wait for 20 us;  -- Simulated echo return time for a close object
        echo <= '0';

        -- Example: Simulate an object at a far distance
        wait for 100 ns;  -- Time between measurements
        trig_pulse <= '1';
        wait for 10 us;
        trig_pulse <= '0';
        echo <= '1';
        wait for 40 us;  -- Simulated echo return time for a far object
        echo <= '0';

        -- Add more scenarios as needed
        -- ...

        wait; -- Will run forever
    end process;
end architecture;

