library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.constants_pkg.all;

entity top_sensor is
    port (
        clk         : in    std_logic;
        rst         : in    std_logic;
        echo        : in    std_logic;
        trig        : out   std_logic;
        above_limit : out   std_logic;
        an          : out   std_logic_vector(AN_WIDTH - 1 downto 0);
        seg         : out   std_logic_vector(SEG_WIDTH - 1 downto 0)
    );
end top_sensor;

architecture arch of top_sensor is
    constant SENSOR_WIDTH : integer := 20;

    signal top_clr  : std_logic;
    signal top_cnt  : std_logic;
    signal top_ld   : std_logic;
    signal top_ucq  : std_logic_vector(SENSOR_WIDTH - 1 downto 0);
    signal top_hrq  : std_logic_vector(SENSOR_WIDTH - 1 downto 0);
    signal top_trq  : std_logic_vector(SENSOR_WIDTH - 1 downto 0);
    signal threshold: std_logic_vector(SENSOR_WIDTH - 1 downto 0);
    signal distance : std_logic_vector(SENSOR_WIDTH - 1 downto 0);
   
begin
    timer_trig : entity work.timer_trig(arch)
    port map (
        clk         => clk,
        rst         => rst,
        trig        => trig
    );
    
    up_counter : entity work.up_counter(arch)
    generic map(CNT_WIDTH => SENSOR_WIDTH)
    port map (
        clk         => clk,
        rst         => rst,
        uc_clr      => top_clr,
        uc_cnt      => top_cnt,
        uc_q        => top_ucq
    );
    
    hold_reg : entity work.reg(arch)
    generic map (REG_WIDTH => SENSOR_WIDTH)
    port map (
        clk         => clk,
        rst         => rst,
        reg_ld      => top_ld,
        reg_d       => top_ucq,
        reg_q       => top_hrq
    );
    
    threshold_reg : entity work.reg(arch)
    generic map (REG_WIDTH => SENSOR_WIDTH)
    port map (
        clk         => clk,
        rst         => rst,
        reg_ld      => '1',
        reg_d       => threshold,
        reg_q       => top_trq
    );
    
    distance_display : entity work.display(arch)
    generic map (NUM_WIDTH => SENSOR_WIDTH)
    port map (
        clk         => clk,
        rst         => rst,
        num         => distance,
        an          => an,
        seg         => seg
    );
    
    control_sensor : entity work.control_sensor(arch)
    port map (
        clk         => clk,
        rst         => rst,
        echo        => echo,
        clr         => top_clr,
        cnt         => top_cnt,
        ld          => top_ld
    );

    -- Comparator
    above_limit <= '0' when top_trq > top_hrq else '1';

     -- Calculate distance by taking the up counter * clk period (20ns) * (343 / 10000000 = 0.0000343) divided by 2 due to the echo going back and forth the same distance
    distance <= std_logic_vector(to_unsigned((to_integer(unsigned(top_ucq)) * 20 * 343) / (2 * 10000000), SENSOR_WIDTH));

end arch;
