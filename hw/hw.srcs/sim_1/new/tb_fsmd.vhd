library ieee;
use ieee.std_logic_1164.all;
use work.constants_pkg.all;

entity tb_fsmd is
end tb_fsmd;

architecture arch of tb_fsmd is
    component top_fsmd
    generic (
        BACK_COUNTER    : integer := 100;
        TURN_COUNTER    : integer := 50;
        THRESHOLD       : std_logic_vector(THRESHOLD_WIDTH - 1 downto 0) := "0000000000100"
    );
    port (
        clk     : in    std_logic;
        rst     : in    std_logic;
        echo    : in    std_logic;
        trig    : inout   std_logic;
        dig_out : out   std_logic_vector(MOTOR_WIDTH - 1 downto 0);
        an      : out   std_logic_vector(3 downto 0);
        seg     : out   std_logic_vector(7 downto 0)
    );
    end component;
    
    -- Inputs
    signal clk      : std_logic;
    signal rst      : std_logic;
    signal echo     : std_logic;
   
    -- Outputs
    signal trig     : std_logic;
    signal dig_out  : std_logic_vector(MOTOR_WIDTH - 1 downto 0);
    signal an       : std_logic_vector(3 downto 0);
    signal seg      : std_logic_vector(7 downto 0);
   
    -- Clock period
    constant clk_period : time := 10 ns;
begin
    -- Unit Under Test (UUT)
    uut : top_fsmd 
    port map (
        clk     => clk,
        rst     => rst,
        echo    => echo,
        trig    => trig,
        dig_out => dig_out,
        an      => an,
        seg     => seg
    );
    
    -- Clock process
    clk_process : process
    begin
        clk <= '0';
        wait for clk_period;
        clk <= '1';
        wait for clk_period;
    end process;
    
    -- Stimulus process
    stim_process : process
        variable echo_pulse_width   : time := 100us;
        variable pulse_variation    : time := 10us;
        variable threshold_time     : time := 1000us;
        variable reversing : boolean := false;
    begin
        rst <= '1';
        wait for clk_period;
        rst <= '0';
        echo <= '0';
        wait for clk_period * 10;
        
        while echo_pulse_width > threshold_time loop
            echo <= '1';
            wait for echo_pulse_width;  -- Echo pulse width represents the distance
            echo <= '0';
            wait for 500 us - echo_pulse_width;  -- Wait before next pulse
    
            if reversing then
                -- If reversing, start increasing the pulse width
                echo_pulse_width := echo_pulse_width + pulse_variation;
            else
                -- If not reversing, decrease the pulse width
                echo_pulse_width := echo_pulse_width - pulse_variation;
            end if;
    
            -- Check if we need to reverse
            if echo_pulse_width <= threshold_time then
                reversing := true;
            end if;
        end loop;
        
        for i in 1 to 5 loop
            echo <= '1';
            wait for echo_pulse_width;  -- Simulate increased distance
            echo <= '0';
            wait for 500 us - echo_pulse_width;
            echo_pulse_width := echo_pulse_width + pulse_variation;  -- Increase the pulse width
        end loop;
--        echo <= '0';
--        wait for clk_period * 5000;
    
--        echo <= '1';
--        wait for 1us;
--        echo <= '0';
--        wait for 5us;

--        echo <= '1';
--        wait for 3us;
--        echo <= '0';
--        wait for 5us;
    
--        echo <= '1';
--        wait for 5us;
--        echo <= '0';
--        wait for 5us;
    end process;
end arch;
