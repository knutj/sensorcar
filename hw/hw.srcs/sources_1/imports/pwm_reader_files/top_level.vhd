-- Listing 6.3 modified
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;


entity pwm_reader is
    port(
        clk, rst, write, pwm_in: in std_logic;
        threshold_limit: in std_logic_vector(19 downto 0);
        over_the_limit: out std_logic;
        width_count: out std_logic_vector(19 downto 0);
        -- Additional ports for Ultrasonic Sensor
        trig_pulse: in std_logic;
        echo: in std_logic;
        trig: out std_logic;
        distance: out unsigned(31 downto 0)
    );
end pwm_reader;



architecture arch of pwm_reader is
   signal top_clr, top_cnt, top_ld: std_logic;
   signal top_ucq, top_hrq, top_trq: std_logic_vector(19 downto 0);
   -- Other signals
    signal start_counter : std_logic;
    constant distance_threshold : unsigned(31 downto 0) := to_unsigned(2, 32);  -- Set your threshold
    signal sensor_distance : unsigned(31 downto 0);
   -- Component declaration for Ultrasonic_Sensor
    component Ultrasonic_Sensor
        Port (
            clk         : in  std_logic;
            reset       : in  std_logic;
            trig_pulse  : in  std_logic;
            echo        : in  std_logic;
            trig        : out std_logic;
            distance    : out unsigned(31 downto 0)
        );
    end component;
begin
   
   -- Instantiate Ultrasonic_Sensor
       sensor_instance: Ultrasonic_Sensor
        port map (
            clk         => clk,
            reset       => rst,
            trig_pulse  => trig_pulse,
            echo        => echo,
            trig        => trig,
            distance    => sensor_distance
        );
    
    -- Logic to start the counter
        start_counter <= '1' when sensor_distance > distance_threshold else '0';

    counter: entity work.up_counter(arch)
        port map(clk=>clk, rst=>rst, uc_clr=>top_clr, uc_cnt=>top_cnt, uc_q=>top_ucq);

    hold_reg: entity work.reg(arch)
        port map(clk=>clk, rst=>rst, reg_ld=>top_ld, reg_d=>top_ucq, reg_q=>top_hrq);

    threshold_reg: entity work.reg(arch)
        port map(clk=>clk, rst=>rst, reg_ld=>write, reg_d=>threshold_limit, reg_q=>top_trq);

    over_the_limit <= '0' when top_trq > top_hrq else '1';

    control_path: entity work.fsm(arch)
        port map(clk=>clk, rst=>rst, pwm_in=>pwm_in, clear=>top_clr, count=>top_cnt, load=>top_ld);

    width_count <= top_hrq;
	
end arch;