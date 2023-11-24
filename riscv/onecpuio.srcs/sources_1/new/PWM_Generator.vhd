----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/24/2023 06:50:46 AM
-- Design Name: 
-- Module Name: PWM_Generator - arch
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity PWM_Generator is
    Port (
        clk : in STD_LOGIC;  -- System clock
        rst : in STD_LOGIC;  -- Reset signal
        pwm_in : in STD_LOGIC; -- PWM input control signal
        pwm_out : out STD_LOGIC  -- PWM output signal
    );
end PWM_Generator;

architecture arch of PWM_Generator is
    signal counter : unsigned(4 downto 0) := (others => '0');  -- Modulo-20 counter (0 to 19)
    signal pwm_duty_cycle : unsigned(4 downto 0);  -- Duty cycle control
begin
    process(clk, rst)
    begin
        if rst = '1' then
            counter <= (others => '0');
        elsif rising_edge(clk) then
            -- Increment counter and reset if it reaches 20
            if counter = 19 then
                counter <= (others => '0');
            else
                counter <= counter + 1;
            end if;

            -- Change duty cycle based on counter value
            pwm_duty_cycle <= counter;

            -- Generate PWM signal
            if pwm_in = '1' then
                pwm_out <= '0';  -- Set output to zero if pwm_in is active
            else
               if counter < pwm_duty_cycle then
                    pwm_out <= '1';
                else
                    pwm_out <= '0';
                end if;       
            end if;
        end if;
    end process;
end arch;