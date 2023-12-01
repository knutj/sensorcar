----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/30/2023 10:37:41 AM
-- Design Name: 
-- Module Name: top - Behavioral
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

----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/30/2023 10:37:41 AM
-- Design Name: 
-- Module Name: top - Behavioral
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
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top is
    Port (  motor_pwm_a   : out std_logic;               -- PWM signal for motor A speed
            motor_dir_a   : out std_logic_vector(1 downto 0); -- Direction control for motor A
            motor_pwm_b   : out std_logic;               -- PWM signal for motor B speed (for turning)
            motor_dir_b   : out std_logic_vector(1 downto 0); -- Direction control for motor B
           trigger : out STD_LOGIC;
           echo : in STD_LOGIC;
           rst : in STD_LOGIC;
           clk : in STD_LOGIC);
end top;

architecture arch of top is
type state_type is (idle, start_motor, send_trigger, check_echo,  stop_motor, reverse_motor, turn_left);
signal state : state_type := idle;
signal counter : integer range 0 to 500 := 0;  -- Example range for counter
signal timer   : integer range 0 to 100 := 0;
signal backwordtimer : integer range 0 to 30 :=0;
begin
    process(clk, rst)
    begin
        if rst = '1' then
            state <= idle;
            counter <= 0;
            timer <= 0;
            motor_pwm_a <= '0';
            motor_pwm_b <= '0';
            motor_dir_a <= "00"; -- Assuming "00" stops the motor
            motor_dir_b <= "00"; -- Assuming "00" stops the motor
            trigger <= '0';
        elsif rising_edge(clk) then
            case state is
                when idle =>
                    trigger <= '0';
                    state <= start_motor;

                when start_motor =>
                    motor_dir_a <= "01"; -- Forward
                    motor_pwm_a <= '1'; -- Full speed
                    state <= send_trigger;

                when send_trigger =>
                    trigger <= '1';
                    state <= check_echo;

                when check_echo =>
                    if (counter < 500) and (echo = '0') then
                        counter <= counter + 1;
                        timer <= timer + 1;
                    elsif (timer < 30) and (echo = '1') then
                        state <= stop_motor;
                    else
                        state <= idle;
                    end if;

                when stop_motor =>
                    -- Stop car logic here
                    motor_pwm_a <= '0'; -- Stop the motor
                    motor_dir_a <= "00"; -- Assuming "00" stops the motor
                    state  <= reverse_motor;
                
                 when reverse_motor =>
                    motor_dir_a <= "10"; -- Reverse
                    motor_pwm_a <= '1'; -- Full speed
                    -- Add delay or condition for reversing time
                    if backwordtimer< 30 then
                       backwordtimer <= backwordtimer +1;
                    else 
                        state <= turn_left;
                    end if;
                    
                when turn_left =>
                    motor_dir_b <= "01"; -- Turn left
                    motor_pwm_b <= '1'; -- Full speed for motor B
                    -- Add delay or condition for turning time
                    if backwordtimer< 30 then
                       backwordtimer <= backwordtimer +1;
                    else 
                       state <= idle;
                    end if;

                when others =>
                    state <= idle;
            end case;
        end if;
    end process;
end arch;
