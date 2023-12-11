library ieee;
use ieee.std_logic_1164.all;
use work.constants_pkg.all;
use work.tb_procedures_pkg.all;

entity tb_asip is
end tb_asip;

architecture arch of tb_asip is
    component top_asip
    port (
        clk     :   in std_logic;
        rst     :   in std_logic;
        echo    :   in std_logic;
        dig_in  :   in std_logic_vector(DIG_DATA_WIDTH - 1 downto 0);
        dig_out :   out std_logic_vector(DIG_DATA_WIDTH - 1 downto 0);
        trig    :   out std_logic
    );
    END component;
    
    -- Inputs
    signal clk      : std_logic;
    signal rst      : std_logic;
    signal echo     : std_logic;
    signal dig_in   : std_logic_vector(DIG_DATA_WIDTH - 1 downto 0);
   
    -- Outputs
    signal dig_out  : std_logic_vector(DIG_DATA_WIDTH - 1 downto 0);
    signal trig     : std_logic;
   
    -- Clock period
    constant clk_period : time := 10 ns;
    
begin
    -- Unit Under Test (UUT)
    uut : top_asip port map (
        clk => clk,
        rst => rst, 
        echo => echo,
        dig_in => dig_in,
        dig_out => dig_out,
        trig => trig
    );

   -- Clock process
   clk_process : process
   begin
		clk <= '0';
		wait for clk_period / 2;
		clk <= '1';
		wait for clk_period / 2;
   end process;
 
   -- Stimulus process
    stim_process: process
        constant MIN_ECHO_DURATION : integer := 20;
        constant MAX_ECHO_DURATION : integer := 100;
        variable echo_duration: integer range 0 to MAX_ECHO_DURATION;
    begin
        rst <= '1';
        wait for clk_period / 2;
        rst <= '0';
        wait for clk_period / 2;
        
        echo <= '0';
        wait for clk_period / 2;
    
        -- Decreasing Echo Duration (Object getting closer)
        echo_duration := MAX_ECHO_DURATION;  -- Start with maximum duration
        while echo_duration > MIN_ECHO_DURATION loop
            echo <= '1';
            wait for echo_duration * 9 us;  -- Echo signal high
            echo <= '0';
            wait for 1 ms - (echo_duration * 2 us);  -- Echo signal low, within 1 ms period
            echo_duration := echo_duration - 10;
        end loop;
    
        -- Increasing Echo Duration (Object moving away)
        while echo_duration < MAX_ECHO_DURATION loop
            echo <= '1';
            wait for echo_duration * 1 us;  -- Echo signal high
            echo <= '0';
            wait for 1 ms - (echo_duration * 1 us);  -- Echo signal low, within 1 ms period
            echo_duration := echo_duration + 10;
        end loop;
    
        -- End simulation (optional)
        wait;
    end process stim_process;
end;