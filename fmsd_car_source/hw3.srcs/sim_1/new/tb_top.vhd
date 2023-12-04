LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY tb_top IS
END tb_top;

ARCHITECTURE behavior OF tb_top IS 

    -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT top
    PORT(
        --motor_pwm_a   : out std_logic;
        --motor_dir_a   : out std_logic_vector(1 downto 0);
        --motor_pwm_b   : out std_logic;
        --motor_dir_b   : out std_logic_vector(1 downto 0);
        motor_pwm     : out std_logic_vector(7 downto 0);
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
   -- signal motor_pwm_a : std_logic;
    --signal motor_dir_a : std_logic_vector(1 downto 0);
    --signal motor_pwm_b : std_logic;
    --signal motor_dir_b : std_logic_vector(1 downto 0);
    signal motor_pwm   : std_logic_vector(7 downto 0); 
    signal trigger     : std_logic;

    -- Clock period definitions
    constant clk_period : time := 10 ns;

BEGIN 

    -- Instantiate the Unit Under Test (UUT)
    uut: top PORT MAP (
        clk         => clk,
        rst         => rst,
        echo        => echo,
        motor_pwm   => motor_pwm,
        trigger     => trigger
    );

    -- Clock process definitions
    --clk_process : PROCESS
    --BEGIN
    --    clk <= '0';
    --    wait for clk_period/2;
     --   clk <= '1';
     --   wait for clk_period/2;
       
    --END PROCESS;

    -- Test process
    stim_proc: PROCESS    BEGIN
    -- Initialize Inputs
        rst <= '1';
        wait for 10 ns;
        
        -- Reset the system
        rst <= '0';
        wait for 100 ns;
        clk <= '1';
        

        -- Simulate echo signal and other test conditions
        -- State: idle -> start_motor
        echo <= '0';
        wait for 500 ns; -- Adjust the timing as needed

        -- State: start_motor -> send_trigger
        trigger <='1';
        motor_pwm(0) <= '1';
        motor_pwm(2) <= '1';
        motor_pwm(4) <= '1';
        motor_pwm(6) <= '1';
        
        wait for 10 ns;
        

        -- State: send_trigger -> check_echo
        -- Simulate object detected
        echo <= '1'; 
        wait for 10 ns;

        -- State: check_echo -> stop_motor
        echo <= '1';
        wait for 10 ns;

        -- State: stop_motor -> reverse_motor
        wait for 10 ns;

        -- State: reverse_motor -> turn_left
        wait for 10 ns;

        -- State: turn_left -> idle
        wait for 10 ns;

        wait for 30 ms;
        wait; -- Will run indefinitely
    END PROCESS;

END behavior;
