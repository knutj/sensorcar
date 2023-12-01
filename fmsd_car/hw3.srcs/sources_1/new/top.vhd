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
    Port ( motor   : out std_logic;
           trigger : out STD_LOGIC;
           echo : in STD_LOGIC;
           rst : in STD_LOGIC;
           clk : in STD_LOGIC);
end top;

architecture arch of top is
type state_type is (idle, start_motor, send_trigger, check_echo, control_motor);
signal state : state_type := idle;
signal counter : integer range 0 to 500 := 0;  -- Example range for counter
signal timer   : integer range 0 to 100 := 0;
begin
    process(clk, rst)
    begin
        if rst = '1' then
            state <= idle;
            counter <= 0;
            timer <= 0;
            trigger <= '0';
        elsif rising_edge(clk) then
            case state is
                when idle =>
                    trigger <= '0';
                    state <= start_motor;

                when start_motor =>
                    state <= send_trigger;

                when send_trigger =>
                    trigger <= '1';
                    state <= check_echo;

                when check_echo =>
                    if (counter < 500) and (echo = '0') then
                        counter <= counter + 1;
                        timer <= timer + 1;
                    elsif (timer < 30) and (echo = '1') then
                        state <= control_motor;
                    else
                        state <= idle;
                    end if;

                when control_motor =>
                    -- Stop car logic here
                    state <= idle;

                when others =>
                    state <= idle;
            end case;
        end if;
    end process;
end arch;
