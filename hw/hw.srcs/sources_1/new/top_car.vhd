library ieee;
use ieee.std_logic_1164.all;
use work.constants_pkg.all;

entity top_car is
    generic (
        BACK_COUNTER    : integer := 100000000; -- Every 2s given 10ns length per clock and 2 x 10ns per rising edge
        TURN_COUNTER    : integer := 50000000  -- Every 1s given 10ns length per clock and 2 x 10ns per rising edge
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
    signal above_limit  : std_logic;
    
    -- Motor timers
    signal start_bw     : std_logic;
    signal done_bw      : std_logic;
    signal start_tl     : std_logic;
    signal done_tl      : std_logic;
   
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
    
--    display : entity work.display(arch)
--    port map (
--        clk         => clk,
--        rst         => rst,
--        num         => top_ucq,
--        an          => an,
--        seg         => seg
--    );

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