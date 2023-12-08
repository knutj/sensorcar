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
            clk, rst : in  std_logic;
            dig_in : in  std_logic_vector(DRDATA_WIDTH-1 downto 0);
            echo_pulse : in std_logic;
            dig_out : out std_logic_vector(DRDATA_WIDTH-1 downto 0)
        );
    END COMPONENT;
    
    -- Inputs
    signal clk : std_logic := '0';
    signal rst : std_logic := '0';
    signal dig_in : std_logic_vector(DRDATA_WIDTH-1 downto 0) := (others => '0');
    signal echoS : std_logic := '0';

    -- Outputs
    signal dig_out : std_logic_vector(DRDATA_WIDTH-1 downto 0);

    -- Clock period definitions
    constant clk_period : time := 10 ns;

BEGIN

    -- Instantiate the Unit Under Test (UUT)
    uut: OneCycleCPUwithIO 
        PORT MAP (
            clk => clk,
            rst => rst, 
            dig_in => dig_in,
            echo_pulse => echoS,
            dig_out => dig_out
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
        -- Reset
        rst <= '1';
        wait for clk_period;    
        rst <= '0';

        -- Stimulus
        dig_in <= "01010101"; -- Example input
        wait for clk_period*64;

        -- Add more test cases here...

        wait; -- Wait indefinitely, simulation ends manually
    end process;

END behavior;