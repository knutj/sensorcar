library ieee;
use ieee.std_logic_1164.all;
use work.constants_pkg.all;

entity top_echo is
    port (
        clk         : in    std_logic;
        rst         : in    std_logic;
        write       : in    std_logic;
        echo        : in    std_logic;
        threshold   : in    std_logic_vector(PWM_WIDTH - 1 downto 0);
        above_limit : out   std_logic;
        width_count : out   std_logic_vector(PWM_WIDTH - 1 downto 0);
        trig        : out   std_logic
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
    trig_counter : entity work.trig_counter(arch)
    port map (
        clk         => clk,
        rst         => rst,
        start       => '1',
        trig        => trig
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
    generic map (REG_WIDTH => PWM_WIDTH)
    port map (
        clk         => clk,
        rst         => rst,
        reg_ld      => top_ld,
        reg_d       => top_ucq,
        reg_q       => top_hrq
    );
    
    threshold_reg : entity work.reg(arch)
    generic map (REG_WIDTH => PWM_WIDTH)
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
        ld          => top_ld
    );
    
    -- Comparator
    above_limit <= '0' when top_trq > top_hrq else '1';
    
    -- Width measurement
    width_count <= top_hrq;

end arch;
