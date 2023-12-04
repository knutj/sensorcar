LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY tb_top IS
END tb_top;

ARCHITECTURE behavior OF tb_top IS 

    -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT top
    PORT(
        motor_pwm     : OUT std_logic_vector(7 downto 0);
        trigger       : OUT std_logic;
        echo          : IN std_logic;
        rst           : IN std_logic;
        clk           : IN std_logic
    );
    END COMPONENT;
   
    -- Inputs
    SIGNAL clk : std_logic := '0';
    SIGNAL rst : std_logic := '1';
    SIGNAL echo : std_logic := '0';

    -- Outputs
    SIGNAL motor_pwm : std_logic_vector(7 downto 0);
    SIGNAL trigger : std_logic;

    -- Clock period definitions
    CONSTANT clk_period : time := 10 ns;

BEGIN 

    -- Instantiate the Unit Under Test (UUT)
    uut: COMPONENT top
        PORT MAP (
            clk       => clk,
            rst       => rst,
            echo      => echo,
            motor_pwm => motor_pwm,
            trigger   => trigger
        );

    -- Clock process definitions
    clk_process : PROCESS
    BEGIN
        clk <= '0';
        WAIT FOR clk_period/2;
        clk <= '1';
        WAIT FOR clk_period/2;
    END PROCESS;

    -- Test process
    stim_proc: PROCESS
    BEGIN
        -- Initialize Inputs
        rst <= '1';
        WAIT FOR 100 ns;
        
        -- Reset the system
        rst <= '0';
        WAIT FOR 100 ns;

        -- Simulate echo signal and other test conditions
        echo <= '0';
        WAIT FOR 10 ns; -- Adjust the timing as needed
        echo <= '1';
        WAIT FOR 10 ns; -- Simulate object detection
        echo <= '0';
        WAIT FOR 400 ns; -- Adjust the timing as needed

        -- Add additional test cases to check other states and behaviors
        -- ...
        
        WAIT; -- Will run indefinitely
    END PROCESS;

END behavior;

