LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY tb_top IS
END tb_top;

ARCHITECTURE behavior OF tb_top IS 

    -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT top
    PORT(
        motor_pwm_a   : out std_logic;
        motor_dir_a   : out std_logic_vector(1 downto 0);
        motor_pwm_b   : out std_logic;
        motor_dir_b   : out std_logic_vector(1 downto 0);
        trigger       : out std_logic;
        echo          : in std_logic;
        rst           : in std_logic;
        clk           : in std_logic
    );
    END COMPONENT;
    
    -- Inputs
    signal clk     : std_logic := '0';
    signal rst     : std_logic := '1';
    signal echo    : std_logic := '0';

    -- Outputs
    signal motor_pwm_a : std_logic;
    signal motor_dir_a : std_logic_vector(1 downto 0);
    signal motor_pwm_b : std_logic;
    signal motor_dir_b : std_logic_vector(1 downto 0);
    signal trigger     : std_logic;

    -- Clock period definitions
    constant clk_period : time := 10 ns;

BEGIN 

    -- Instantiate the Unit Under Test (UUT)
    uut: top PORT MAP (
        clk         => clk,
        rst         => rst,
        echo        => echo,
        motor_pwm_a => motor_pwm_a,
        motor_dir_a => motor_dir_a,
        motor_pwm_b => motor_pwm_b,
        motor_dir_b => motor_dir_b,
        trigger     => trigger
    );

    -- Clock process definitions
    clk_process : PROCESS
    BEGIN
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    END PROCESS;

    -- Test process
    stim_proc: PROCESS
    BEGIN
        -- Initialize Inputs
        rst <= '1';
        wait for 100 ns;
        
        -- Reset the system
        rst <= '0';
        wait for 100 ns;

        -- Simulate echo signal and other test conditions
        echo <= '0';
        wait for 500 ns; -- Adjust the timing as needed
        echo <= '1';
        wait for 100 ns; -- Adjust the timing as needed
        echo <= '0';
        wait for 400 ns; -- Adjust the timing as needed
        -- ... Add more test cases as needed ...
        trigger <= '1';
        wait for 10 ms;
        echo <= '1';
        trigger  <= '1';
        wait for 30 ms;
        wait; -- Will run indefinitely
    END PROCESS;

END behavior;
