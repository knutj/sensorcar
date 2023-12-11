library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.constants_pkg.all;

entity motors is
    port (
        clk         : in    std_logic;
        rst         : in    std_logic;
        mot_en      : in    std_logic;
        mot_lfw     : in    std_logic;
        mot_rfw     : in    std_logic;
        mot_q       : out   std_logic_vector(MOTOR_WIDTH - 1 downto 0)
    );
end motors;

architecture arch of motors is
    constant FORWARD    : std_logic_vector(3 downto 0) := "0101";
    constant BACKWARD   : std_logic_vector(3 downto 0) := "1010";
    signal pwm          : std_logic;
    
begin
    -- Combined output signal
    process (clk, rst, mot_rfw, mot_lfw)
    begin
        if rst = '1' then
            mot_q <= (others => '0');
        elsif rising_edge(clk) then
            if mot_en = '1' then
                pwm <= '1'; -- PWM is constantly 1, which means motors are going full speed
                
                if mot_rfw = '1' and mot_lfw = '1' then
                    mot_q <= pwm & FORWARD & FORWARD;
                elsif mot_rfw = '0' and mot_lfw = '0' then
                    mot_q <= pwm & BACKWARD & BACKWARD;
                elsif mot_rfw = '1' and mot_lfw = '0' then
                    mot_q <= pwm & FORWARD & BACKWARD;
                elsif mot_rfw = '0' and mot_lfw = '1' then
                    mot_q <= pwm & BACKWARD & FORWARD;
                end if;
            else
                mot_q <= (others => '0');
            end if;
        end if;
    end process;
end arch;