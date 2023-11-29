LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY tb_pwm_reader IS
END tb_pwm_reader;

ARCHITECTURE arch OF tb_pwm_reader IS 
    -- Component Declaration for the Unit Under Test (UUT) 
    COMPONENT pwm_reader
        PORT(
            clk, rst, write, pwm_in: in std_logic;
            threshold_limit: in std_logic_vector(19 downto 0);
            over_the_limit: inout std_logic;
            width_count: out std_logic_vector(19 downto 0);
            -- Ports for MotorControl
            motor_pwm_out: out std_logic;
            motor_dir_A, motor_dir_B: out std_logic_vector(1 downto 0);
            -- Ports for Ultrasonic Sensor
            sensor_trig: out std_logic;
            sensor_echo: in std_logic;
            sensor_distance: inout integer
        );
    END COMPONENT;

    -- Additional Component Declaration for MotorControl
    COMPONENT MotorControl
        PORT(
            stop        : in std_logic;
            clk         : in std_logic;
            reset       : in std_logic;
            pwm_out     : out std_logic;
            motor_dir_A : out std_logic_vector(1 downto 0);
            motor_dir_B : out std_logic_vector(1 downto 0)
        );
    END COMPONENT;

    -- Inputs
    signal clk : std_logic := '0';
    signal rst : std_logic;
    signal write : std_logic;
    signal pwm_in : std_logic;
    signal threshold_limit : std_logic_vector(19 downto 0);

    -- Outputs
    signal over_the_limit : std_logic;
    signal width_count : std_logic_vector(19 downto 0);

    -- Additional signals for MotorControl
    signal motor_stop        : std_logic;
    signal motor_pwm_out     : std_logic;
    signal motor_dir_A       : std_logic_vector(1 downto 0);
    signal motor_dir_B       : std_logic_vector(1 downto 0);

    -- Signals for Ultrasonic Sensor
    signal sensor_trig       : std_logic;
    signal sensor_echo       : std_logic;
    signal sensor_distance   : integer;

    -- Clock period definition
    constant clk_period : time := 10 ns;

BEGIN
    -- Instantiate the PWM Reader Unit Under Test (UUT)
    uut_pwm_reader: pwm_reader PORT MAP (
        clk             => clk,
        rst             => rst,
        write           => write,
        pwm_in          => pwm_in,
        threshold_limit => threshold_limit,
        over_the_limit  => over_the_limit,
        width_count     => width_count,
        motor_pwm_out   => motor_pwm_out,
        motor_dir_A     => motor_dir_A,
        motor_dir_B     => motor_dir_B,
        sensor_trig     => sensor_trig,
        sensor_echo     => sensor_echo,
        sensor_distance => sensor_distance
    );

    -- Instantiate the MotorControl
    uut_motor_control: MotorControl PORT MAP (
        stop        => motor_stop,
        clk         => clk,
        reset       => rst,
        pwm_out     => motor_pwm_out,
        motor_dir_A => motor_dir_A,
        motor_dir_B => motor_dir_B
    );

    -- Clock process definition
    clk_process: process
    begin
        clk <= '0';
        wait for clk_period / 2;
        clk <= '1';
        wait for clk_period / 2;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        -- Initialize Inputs
        rst <= '1';
        wait for clk_period;  
        rst <= '0';

        -- Test PWM Reader Functionality
        -- ... (existing code) ...

        -- Test MotorControl Functionality
        -- ... (existing code) ...

        -- Test Ultrasonic Sensor Functionality
        -- Example: Simulate sensor echo and distance
        sensor_trig <= '1';
        wait for 10 ns;  -- Simulate sensor trigger
        sensor_trig <= '0';
        sensor_echo <= '1';
        wait for 500 ns; -- Simulate echo return time
        sensor_echo <= '0';
        sensor_distance <= 50; -- Example distance value

        -- ... (additional code for testing) ...

        wait; -- Will run indefinitely
    end process;
END arch;
