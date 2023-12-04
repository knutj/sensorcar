library ieee;
use ieee.std_logic_1164.all;
use work.constants_pkg.all;

entity top_echo is
     generic (
        N : integer := 9;  -- Number of bits (E.g. 2^N > M)
        M : integer := 501 -- Modulus M
    );
    port (
        clk         : in    std_logic;
        rst         : in    std_logic;
        write       : in    std_logic;
        echo        : in    std_logic;
        threshold   : in    std_logic_vector(PWM_WIDTH - 1 downto 0);
        above_limit : out   std_logic;
        width_count : out   std_logic_vector(PWM_WIDTH - 1 downto 0);
        max_tick    : out   std_logic;
        mc_q        : out   std_logic_vector(N - 1 downto 0)
    );
end top_echo;

architecture arch of top_echo is
    signal top_clr  : std_logic;
    signal top_cnt  : std_logic;
    signal top_ld   : std_logic;
    signal top_ucq  : std_logic_vector(PWM_WIDTH - 1 downto 0);
    signal top_hrq  : std_logic_vector(PWM_WIDTH - 1 downto 0);
    signal top_trq  : std_logic_vector(PWM_WIDTH - 1 downto 0);
begin


    maxcounter : entity work.mod_m_counter(arch)
    port map (
        clk => clk,
        rst => rst,
        max_tick => max_tick,
        mc_q  => mc_q 
        );

    up_counter : entity work.up_counter(arch)
    port map (
        clk         => clk,
        rst         => rst,
        uc_clr      => top_clr,
        uc_cnt      => top_cnt,
        uc_q        => top_ucq
    );
    
    hold_reg : entity work.reg_echo(arch)
    port map (
        clk         => clk,
        rst         => rst,
        reg_ld      => top_ld,
        reg_d       => top_ucq,
        reg_q       => top_hrq
    );
    
    threshold_reg : entity work.reg_echo(arch)
    port map (
        clk         => clk,
        rst         => rst,
        reg_ld      => write,
        reg_d       => threshold,
        reg_q       => top_trq
    );
    
    control : entity work.control_echo(arch)
    port map (
        clk         => clk,
        rst         => rst,
        echo        => echo,
        clr         => top_clr,
        cnt         => top_cnt,
        ld          => top_ld,
        max_tick    => max_tick
    );
    
    -- Comparator
    above_limit <= '0' when top_trq > top_hrq else '1';
    
    

    
    -- Width measurement
    width_count <= top_hrq;

end arch;
