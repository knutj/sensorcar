library ieee;
use ieee.std_logic_1164.all;
use work.constants_pkg.all;

entity top_fsmd is
    generic (
        ECHO_COUNTER    : integer := 500;
        BACK_COUNTER    : integer := 1000000;
        TURN_COUNTER    : integer := 500000;
        THRESHOLD       : std_logic_vector(THRESHOLD_WIDTH - 1 downto 0) := "0000010000000";
        N : integer := 9;  -- Number of bits (E.g. 2^N > M)
        M : integer := 501 -- Modulus M
    );
    port (
        clk     : in    std_logic;
        rst     : in    std_logic;
        echo    : in    std_logic;
        trig    : out   std_logic;
        dig_out : out   std_logic_vector(MOTOR_WIDTH - 1 downto 0);
        an      : out   std_logic_vector(AN_WIDTH - 1 downto 0);
        seg     : out   std_logic_vector(SEG_WIDTH - 1 downto 0);
        max_t    :  out   std_logic;
        mc_q        : out   std_logic_vector(N - 1 downto 0)
    );
end top_fsmd;

architecture arch of top_fsmd is
    signal top_clr      : std_logic;
    signal top_cnt      : std_logic;
    signal top_ld       : std_logic;
    signal top_ucq      : std_logic_vector(THRESHOLD_WIDTH - 1 downto 0);
    signal top_hrq      : std_logic_vector(THRESHOLD_WIDTH - 1 downto 0);
    signal top_trq      : std_logic_vector(THRESHOLD_WIDTH - 1 downto 0);
    signal above_limit  : std_logic;
    signal motors       : std_logic_vector(7 downto 0);
    
    -- Motor timers
    signal start_bw     : std_logic;
    signal timeup_bw    : std_logic;
    signal start_tl     : std_logic;
    signal timeup_tl    : std_logic;
    signal max_t_signal : std_logic;
    signal trig_signal : std_logic;
    
begin
    countM : entity work.mod_m_counter(arch) 
    port map (clk => clk,
              rst => rst,
              max_t => max_t,
              mc_q => mc_q
              ); 
   
    echo_timer : entity work.timer(arch)
    generic map (
        LIMIT       => ECHO_COUNTER,
        MODE        => '0'
    )
    port map (
        clk         => clk,
        rst         => rst,
        start       => '1',
        timer_q     => trig
    );
    
    up_counter : entity work.up_counter(arch)
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
    
    motor_reg : entity work.reg(arch)
    generic map (REG_WIDTH => MOTOR_WIDTH)
    port map (
        clk         => clk,
        rst         => rst,
        reg_ld      => '1',
        reg_d       => motors,
        reg_q       => dig_out
    );
    
    backward_timer : entity work.timer(arch)
    generic map (LIMIT => BACK_COUNTER)
    port map (
        clk         => clk,
        rst         => rst,
        start       => start_bw,
        timer_q     => timeup_bw
    );
    
    turnleft_timer : entity work.timer(arch)
    generic map (LIMIT => TURN_COUNTER)
    port map (
        clk         => clk,
        rst         => rst,
        start       => start_tl,
        timer_q     => timeup_tl
    );
    
    display : entity work.display(arch)
    port map (
        clk         => clk,
        rst         => rst,
        num         => top_ucq,
        an          => an,
        seg         => seg
    );
    
    control : entity work.control(arch)
    port map (
        clk         => clk,
        rst         => rst,
        echo        => echo,
        above_limit => above_limit,
        timeup_bw   => timeup_bw,
        timeup_tl   => timeup_tl,
        clr         => top_clr,
        cnt         => top_cnt,
        ld          => top_ld,
        motors      => motors,
        start_bw    => start_bw,
        start_tl    => start_tl,
        trig       => trig_signal,
        max_t      => max_t_signal
    );
    
    -- Comparator
    above_limit <= '0' when top_trq > top_hrq or rst = '1' else '1';

end arch;
