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
        -- motor_stop: in std_logic; -- Signal to stop motors
        motor_pwm_out: out std_logic; -- PWM output for motor speed control
        motor_dir_A, motor_dir_B: out std_logic_vector(1 downto 0) -- Motor direction control);
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

    --Inputs
    signal clk : std_logic := '0';
    signal rst : std_logic;
    signal write : std_logic;
    signal pwm_in : std_logic;
    signal threshold_limit : std_logic_vector(19 downto 0);

    --Outputs
    signal over_the_limit : std_logic;
    signal width_count : std_logic_vector(19 downto 0);

    -- Additional signals for MotorControl
    signal motor_stop        : std_logic;
    signal motor_pwm_out     : std_logic;
    signal motor_dir_A       : std_logic_vector(1 downto 0);
    signal motor_dir_B       : std_logic_vector(1 downto 0);

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
        width_count     => width_count
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
        threshold_limit <= "00000000111100001111"; -- 3855
        write <= '1';
        wait for clk_period;
        write <= '0';
        for i in 0 to 3 loop
            pwm_in <= '1';
            wait for clk_period * 5000;
            pwm_in <= '0';
            wait for clk_period * 95000;
        end loop;
        
        threshold_limit <= "00000001111100001111"; -- 7951
        write <= '1';
        wait for clk_period;
        write <= '0';
        for i in 0 to 3 loop
            pwm_in <= '1';
            wait for clk_period * 5000;
            pwm_in <= '0';
            wait for clk_period * 95000;
        end loop;

        -- Test MotorControl Functionality
        -- Example: Toggle motor stop/start and change direction
        motor_stop <= '0'; -- Start motor
        for i in 0 to 3 loop
            -- Test various motor directions and speeds
            motor_stop <= '1';
            motor_stop <= '0';
            
            -- ...
        end loop;
        motor_stop <= '1'; -- Stop motor

        wait; -- Will run indefinitely
    end process;

END arch;
