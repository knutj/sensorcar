library ieee;
use ieee.std_logic_1164.all;
use work.constants_pkg.all;

<<<<<<< HEAD
entity top_car is
    generic (
        BACK_COUNTER    : integer := 100000000; -- Every 2s given 10ns length per clock and 2 x 10ns per rising edge
        TURN_COUNTER    : integer := 50000000   -- Every 1s given 10ns length per clock and 2 x 10ns per rising edge
        --FW_THRESHOLD    : std_logic_vector(SENSOR_WIDTH - 1 downto 0) := "00001110" & "000000000000";
        --BW_THRESHOLD    : std_logic_vector(SENSOR_WIDTH - 1 downto 0) := "00100011" & "000000000000"
-- Regarding threshold limits, the values below are concatenations between 12 0-bits and any value (As in the ASIP)
-- Choosing 20 cm as minimum and 50 cm as maximum, for forward and backward limits respectively
-- The equation is range = (time * speed) / 2, where time is the time for echo in high and speed is 340m/s = 34,000cm/s = 0.034cm/us = 0.000034cm/ns
-- Time is calculated using the up counter, and its counts on each rising clock, which means it counts every 20ns (As the clock high is 10ns)
-- Time = 2 * range / speed = 2 * 20 cm / 0.000034 cm/ns = 1,176,470 ns => divided by 20 gives about 58,823
-- 1110 0000 0000 0000 is equal to 57,344, close to the value above, therefore FW_THRESHOLD is set to 1110 + 12 0-bits
    );
    port (
        clk     : in    std_logic;
        rst     : in    std_logic;
        en      : in    std_logic;
        echo    : in    std_logic;
        trig    : out   std_logic;
        dig_out : out   std_logic_vector(MOTOR_WIDTH - 1 downto 0);
        an      : out   std_logic_vector(AN_WIDTH - 1 downto 0);
        seg     : out   std_logic_vector(SEG_WIDTH - 1 downto 0)
    );
end top_car;

architecture arch of top_car is
    signal mot_en       : std_logic;
    signal mot_lfw      : std_logic;
    signal mot_rfw      : std_logic;
    signal mot_q        : std_logic_vector(MOTOR_WIDTH - 1 downto 0);
    --signal threshold    : std_logic_vector(SENSOR_WIDTH - 1 downto 0);

    signal above_limit  : std_logic;
    
    -- Motor timers
    signal start_bw     : std_logic;
    signal done_bw      : std_logic;
    signal start_tl     : std_logic;
    signal done_tl      : std_logic;

    -- Hold value for assignment to dig_out and led
    --signal dig_out_tmp  : std_logic_vector(MOTOR_WIDTH - 1 downto 0);

   
begin
    motors : entity work.motors(arch)
    port map (
        clk         => clk,
        rst         => rst,
        mot_en      => mot_en,
        mot_lfw     => mot_lfw,
        mot_rfw     => mot_rfw,
        mot_q       => mot_q
    );
    
    motor_reg : entity work.reg(arch)
    generic map (REG_WIDTH => MOTOR_WIDTH)
    port map (
        clk         => clk,
        rst         => rst,
        reg_ld      => '1',
        reg_d       => mot_q,
        reg_q       => dig_out

    );
    
    backward_timer : entity work.timer(arch)
    generic map (LIMIT => BACK_COUNTER)
    port map (
        clk         => clk,
        rst         => rst,
        start       => start_bw,
        done        => done_bw
    );
    
    turnleft_timer : entity work.timer(arch)
    generic map (LIMIT => TURN_COUNTER)
    port map (
        clk         => clk,
        rst         => rst,
        start       => start_tl,
        done        => done_tl
    );


    control_car : entity work.control_car(arch)
    port map (
        clk         => clk,
        rst         => rst,
        en          => en,
        above_limit => above_limit,
        done_bw     => done_bw,
        done_tl     => done_tl,
        mot_en      => mot_en,
        mot_lfw     => mot_lfw,
        mot_rfw     => mot_rfw,
        start_bw    => start_bw,
        start_tl    => start_tl
    );
    
    top_sensor : entity work.top_sensor(arch)
    port map (
        clk         => clk,
        rst         => rst,
        echo        => echo,
        trig        => trig,
        above_limit => above_limit
    );


end arch;
