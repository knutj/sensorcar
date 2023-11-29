----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/29/2023 05:27:16 PM
-- Design Name: 
-- Module Name: Ultrasonic_Sensor_Controller - Behavioral
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

entity Ultrasonic_Sensor_Controller is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           trigPin : out STD_LOGIC;
           echoPin : in STD_LOGIC;
           led : out STD_LOGIC;
           led2 : out STD_LOGIC;
           distance: inout integer);
end Ultrasonic_Sensor_Controller;

architecture arch of Ultrasonic_Sensor_Controller is
    signal trigSignal  : std_logic := '0';
    signal echoSignal  : std_logic;
    -- signal distance    : integer;
    signal duration    : integer;
    constant clk_freq  : integer := 50000000; -- Clock frequency in Hz (adjust as per your FPGA clock)
    constant delay_cnt : integer := clk_freq / 1000000 * 10; -- 10 microseconds delay count
    type state_type is (idle, trigger_pulse, wait_echo, calculate);
    signal state       : state_type := idle;
    signal counter     : integer := 0;
    constant SOUND_SPEED_CM_PER_SEC : integer := 34300; -- Speed of sound in cm/s
    constant CLOCK_FREQ_HZ : integer := 50000000; -- 50 MHz clock, for example
begin
    process(clk, rst)
    begin
        if rst = '1' then
            state <= idle;
            counter <= 0;
            trigSignal <= '0';
        elsif rising_edge(clk) then
            case state is
                when idle =>
                    counter <= 0;
                    trigSignal <= '0';
                    if counter < delay_cnt then
                        state <= trigger_pulse;
                    end if;

                when trigger_pulse =>
                    trigSignal <= '1';
                    if counter >= delay_cnt then
                        state <= wait_echo;
                        counter <= 0;
                    else
                        counter <= counter + 1;
                    end if;

                when wait_echo =>
                    trigSignal <= '0';
                    if echoPin = '1' then
                        state <= calculate;
                    end if;

                when calculate =>
                    duration <= counter; -- Capture echo duration
                    distance <= (duration * SOUND_SPEED_CM_PER_SEC) / (2 * CLOCK_FREQ_HZ);  
                    if distance < 4 then
                        led <= '1';
                        led2 <= '0';
                    else
                        led <= '0';
                        led2 <= '1';
                    end if;
                    state <= idle;

                when others =>
                    state <= idle;
            end case;
        end if;
    end process;
end arch;