----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 29.11.2023 11:03:38
-- Design Name: 
-- Module Name: MotorControl - arch
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 29.11.2023 09:40:06
-- Design Name: 
-- Module Name: motor - Behavioral
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity MotorControl is
    Port (
        stop        : in std_logic;
        clk         : in std_logic;  -- System clock
        reset       : in std_logic;  -- System reset
        pwm_out     : out std_logic; -- PWM output for speed control
        motor_dir_A : out std_logic_vector(1 downto 0); -- Direction control for motor A
        motor_dir_B : out std_logic_vector(1 downto 0)  -- Direction control for motor B
    );
end MotorControl;

architecture arch of MotorControl is
    signal pwm_counter : integer range 0 to 255 := 0; -- Counter for PWM
    signal pwm_duty_cycle : integer range 0 to 255 := 255; -- Duty cycle for PWM
    signal direction_control : std_logic_vector(1 downto 0) := "01"; -- Initial direction
begin

    -- PWM Generator Process
    pwm_process: process(clk, reset)
    begin
        if reset = '1' then
            pwm_counter <= 0;
            pwm_out <= '0';
        elsif rising_edge(clk) then
            if pwm_counter < pwm_duty_cycle then
                pwm_out <= '1';
            else
                pwm_out <= '0';
            end if;

            -- Reset the counter if it reaches max value
            if pwm_counter = 255 then
                pwm_counter <= 0;
            else
                pwm_counter <= pwm_counter + 1;
            end if;
        end if;
    end process pwm_process;

    -- Motor Direction Control Process
    direction_process: process(clk, reset)
    begin
        if reset = '1' then
            motor_dir_A <= "00";
            motor_dir_B <= "00";
        elsif rising_edge(clk) then
            -- Example: Toggle direction every N clock cycles
            -- This is just an example. Modify as needed for your application
            if stop = '1' then
                motor_dir_A <= "00";
                motor_dir_B <= "00";
            elsif pwm_counter = 0 then
                direction_control <= not direction_control;
                motor_dir_A <= direction_control;
                motor_dir_B <= direction_control;
            end if;    
        end if;
    end process direction_process;

end arch;
