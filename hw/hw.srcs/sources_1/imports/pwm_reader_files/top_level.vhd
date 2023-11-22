-- Listing 6.3 modified
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pwm_reader is
   port(clk, rst, write, pwm_in: in std_logic;
        threshold_limit: in std_logic_vector(19 downto 0);
        over_the_limit: out std_logic;
        width_count: out std_logic_vector(19 downto 0);
         -- HC-SR04 sensor pins
        trig: out std_logic;
        echo: in std_logic);
end pwm_reader;

architecture arch of pwm_reader is
   signal top_clr, top_cnt, top_ld: std_logic;
   signal top_ucq, top_hrq, top_trq: std_logic_vector(19 downto 0);
   
   -- Signals for HC-SR04 sensor interface
   signal trig_pulse: std_logic;
   signal echo_duration: unsigned(19 downto 0);
   signal distance: unsigned(19 downto 0);
   -- Additional signals and constants as needed
   constant some_scaling_factor : unsigned := to_unsigned(58, 19);
 


begin
    -- Instantiate up counter
    counter: entity work.up_counter(arch)
    port map(clk=>clk, rst=>rst, uc_clr=>top_clr, 
             uc_cnt=>top_cnt, uc_q=>top_ucq);
   
    -- Instantiate hold register
    hold_reg: entity work.reg(arch)
    port map(clk=>clk, rst=>rst,
             reg_ld=>top_ld, reg_d=>top_ucq,
             reg_q=>top_hrq);
    
    -- Instantiate threshold register
    threshold_reg: entity work.reg(arch)
    port map(clk=>clk, rst=>rst,
             reg_ld=>write, reg_d=>threshold_limit,             
             reg_q=>top_trq);
               
    -- Comparator circuit
    over_the_limit <= '0' when top_trq > top_hrq else '1';
    
    -- Instantiate FSM control path
    control_path: entity work.fsm(arch)
    port map(clk=>clk, rst=>rst, pwm_in=>pwm_in, 
             clear=>top_clr, count=>top_cnt, load=>top_ld);
    
    -- Width measurement output
    width_count <= top_hrq;

    -- HC-SR04 Sensor Logic
    -- Trigger Pulse Generation
    trig_gen: process(clk, rst)
        variable counter: integer range 0 to 50000 := 0; -- Adjust based on clock frequency for 10us pulse
    begin
        if rising_edge(clk) then
            if rst = '1' then
                counter := 0;
                trig <= '0';
            elsif counter = 0 then
                trig <= '1';
                counter := counter + 1;
            elsif counter = 10 then -- Adjust the value for 10us pulse length based on clock frequency
                trig <= '0';
                counter := 0;
            else
                counter := counter + 1;
            end if;
        end if;
    end process;

    -- Echo Duration Measurement
    echo_measure: process(clk, rst)
        variable start_time: unsigned(19 downto 0) := (others => '0');
        variable end_time: unsigned(19 downto 0) := (others => '0');
        variable measuring: boolean := false;
    begin
        if rising_edge(clk) then
            if rst = '1' then
                start_time := (others => '0');
                end_time := (others => '0');
                measuring := false;
            elsif echo = '1' and not measuring then
                measuring := true;
                start_time := unsigned(top_ucq);
            elsif echo = '0' and measuring then
                end_time := unsigned(top_ucq);
                measuring := false;
                echo_duration <= end_time - start_time;
            end if;
        end if;
    end process;

    -- Distance Calculation (assuming speed of sound ~343 m/s)
    -- Adjust the calculation based on your system's clock frequency
    distance <= echo_duration / (some_scaling_factor);

    -- Logic to influence pwm_in and threshold_limit based on distance
    -- This part of the logic needs to be designed based on how you want to use the distance measurement
    -- For example, you might want to set pwm_in or modify threshold_limit if the distance is below a certain threshold

end arch;