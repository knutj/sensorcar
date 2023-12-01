library ieee;
use ieee.std_logic_1164.all;
use work.constants_pkg.all;
use work.tb_procedures_pkg.all;

entity tb_echo is
end tb_echo;

architecture arch of tb_echo is
    component top_echo
    port (
        clk         : in    std_logic;
        rst         : in    std_logic;
        write       : in    std_logic;
        pwm_in      : in    std_logic;
        threshold   : in    std_logic_vector(PWM_WIDTH - 1 downto 0);
        over_limit  : out   std_logic;
        width_count : out   std_logic_vector(PWM_WIDTH - 1 downto 0)
    );
    end component;
    
    -- Inputs
    signal clk          : std_logic;
    signal rst          : std_logic;
    signal write        : std_logic;
    signal pwm_in       : std_logic;
    signal threshold    : std_logic_vector(PWM_WIDTH - 1 downto 0);
    
    -- Outputs
    signal over_limit   : std_logic;
    signal width_count  : std_logic_vector(PWM_WIDTH - 1 downto 0);
    
    -- Clock period
    constant clk_period : time := 10ns;
begin
    -- Unit Under Test (UUT)
    uut : top_echo port map ( 
       clk          => clk,
       rst          => rst,
       threshold    => threshold,
       write        => write,
       pwm_in       => pwm_in,
       width_count  => width_count,
       over_limit   => over_limit 
    );
    
    -- Clock process
    clk_process : process
    begin
        clk <= '0';
        wait for clk_period / 2;
        clk <= '1';
        wait for clk_period / 2;
    end process;

    -- Stimulus process
    stim_process : process
    begin
        rst <= '1';
        wait for clk_period;
        rst <= '0';
        pwm_threshold(threshold, write, "00000000111100001111", clk_period); -- 3855
        pwm_loop(pwm_in, clk_period, 0, 3, 5000, 95000);
        pwm_threshold(threshold, write, "00000001111100001111", clk_period); -- 7951
        pwm_loop(pwm_in, clk_period, 0, 3, 5000, 95000);
        pwm_loop(pwm_in, clk_period, 0, 3, 30000, 70000);
    end process;
end arch;
