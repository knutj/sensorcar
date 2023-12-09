library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.constants_pkg.all;

package tb_procedures_pkg is
    procedure pwm_loop (
        signal pwm_in   : out std_logic; 
        clk_period      : in time; 
        start_i         : in integer;
        end_i           : in integer;
        mp1             : in integer; 
        mp2             : in integer
    );
    procedure pwm_threshold (
        signal threshold: out std_logic_vector(SENSOR_WIDTH - 1 downto 0); 
        signal write    : out std_logic;
        new_threshold   : in std_logic_vector(SENSOR_WIDTH - 1 downto 0);
        clk_period      : in time
    );
end package tb_procedures_pkg;

package body tb_procedures_pkg is
    procedure pwm_loop (
        signal pwm_in   : out std_logic; 
        clk_period      : in time; 
        start_i         : in integer;
        end_i           : in integer;
        mp1             : in integer; 
        mp2             : in integer
    ) is
    begin
        for i in start_i to end_i loop
            pwm_in <= '1';
            wait for clk_period * mp1;
            pwm_in <= '0';
            wait for clk_period * mp2;
        end loop;
    end procedure pwm_loop;
    
    procedure pwm_threshold (
        signal threshold: out std_logic_vector(SENSOR_WIDTH - 1 downto 0); 
        signal write    : out std_logic;
        new_threshold   : in std_logic_vector(SENSOR_WIDTH - 1 downto 0);
        clk_period      : in time
    ) is
    begin
        threshold <= new_threshold;
        write <= '1';
        wait for clk_period;
        write <= '0';
    end procedure pwm_threshold;
end package body tb_procedures_pkg;