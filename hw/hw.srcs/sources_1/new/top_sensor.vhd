library ieee;
use ieee.std_logic_1164.all;
<<<<<<< HEAD
=======
use ieee.numeric_std.all;
use work.constants_pkg.all;
>>>>>>> main

entity top_sensor is
    port (
        clk         : in    std_logic;
        rst         : in    std_logic;
<<<<<<< HEAD
        echo        : in    std_logic;
        trig        : out   std_logic;
        above_limit : out   std_logic
=======
        threshold   : in    std_logic_vector(SENSOR_WIDTH - 1 downto 0);
        echo        : in    std_logic;
        trig        : out   std_logic;
        above_limit : out   std_logic;
        an          : out   std_logic_vector(AN_WIDTH - 1 downto 0);
        seg         : out   std_logic_vector(SEG_WIDTH - 1 downto 0)
>>>>>>> main
    );
end top_sensor;

architecture arch of top_sensor is
    constant THRESHOLD_WIDTH : integer := 13;
    signal top_clr  : std_logic;
    signal top_cnt  : std_logic;
    signal top_ld   : std_logic;
    signal top_ucq  : std_logic_vector(THRESHOLD_WIDTH - 1 downto 0);
    signal top_hrq  : std_logic_vector(THRESHOLD_WIDTH - 1 downto 0);
    signal top_trq  : std_logic_vector(THRESHOLD_WIDTH - 1 downto 0);
    signal threshold: std_logic_vector(THRESHOLD_WIDTH - 1 downto 0) := "0000100000000";

   
begin
    timer_trig : entity work.timer_trig(arch)
    port map (
        clk         => clk,
        rst         => rst,
        trig        => trig
    );
    
    up_counter : entity work.up_counter(arch)
    generic map(CNT_WIDTH => THRESHOLD_WIDTH)
    port map (
        clk         => clk,
        rst         => rst,
        uc_clr      => top_clr,
        uc_cnt      => top_cnt,
        uc_q        => top_ucq
    );
    
    hold_reg : entity work.reg(arch)

    generic map (REG_WIDTH => THRESHOLD_WIDTH)
    port map (
        clk         => clk,
        rst         => rst,
        reg_ld      => top_ld,
        reg_d       => top_ucq,
        reg_q       => top_hrq
    );
    
    threshold_reg : entity work.reg(arch)
    generic map (REG_WIDTH => THRESHOLD_WIDTH)
    port map (
        clk         => clk,
        rst         => rst,
        reg_ld      => '1',
        reg_d       => THRESHOLD,
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
    

    
    -- Comparator
    above_limit <= '0' when top_trq > top_hrq else '1';


end arch;
