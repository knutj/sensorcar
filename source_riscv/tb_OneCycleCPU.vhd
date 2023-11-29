LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY tb_OneCycleCPUwithIO IS
    generic(
        DRDATA_WIDTH: integer:=8      
    );
END tb_OneCycleCPUwithIO;

ARCHITECTURE behavior OF tb_OneCycleCPUwithIO IS 
    -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT OneCycleCPUwithIO
    PORT(
        clk, rst: in std_logic;
        dig_in: in std_logic_vector(DRDATA_WIDTH-1 downto 0);
        pwm_in: in std_logic; -- Added pwm_in
        dig_out: out std_logic_vector(DRDATA_WIDTH-1 downto 0);
        pwm_out: inout std_logic -- Added pwm_out
    );
    END COMPONENT;

    --Inputs
    signal clk : std_logic;
    signal rst : std_logic;
    signal dig_in: std_logic_vector(DRDATA_WIDTH-1 downto 0);
    signal pwm_in: std_logic; -- Signal for pwm_in

    --Outputs
    signal dig_out: std_logic_vector(DRDATA_WIDTH-1 downto 0);
    signal pwm_out: std_logic; -- Signal for observing pwm_out

    -- Clock period definitions
    constant clk_period : time := 10 ns;

BEGIN
    -- Instantiate the Unit Under Test (UUT)
    uut: OneCycleCPUwithIO PORT MAP (
        clk => clk,
        rst => rst, 
        dig_in => dig_in,
        pwm_in => pwm_in, -- Connect pwm_in
        dig_out => dig_out,
        pwm_out => pwm_out -- Connect pwm_out
    );

    -- Clock process definitions
    clk_process : process
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
        dig_in <= "01010101";

        -- Simulating pwm_in behavior
        pwm_in <= '0';
        wait for clk_period*20;
        pwm_in <= '1'; -- Change pwm_in as needed for testing
        wait for clk_period*64;
    end process;

END;
