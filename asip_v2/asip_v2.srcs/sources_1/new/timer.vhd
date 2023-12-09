----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/06/2023 10:07:01 PM
-- Design Name: 
-- Module Name: timer - arch
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

entity timer is
    generic (
        LIMIT   : integer;
        MODE    : std_logic := '1' -- Mode: '0' for echo trigger
    );
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           start : in STD_LOGIC;
           timer_q : out STD_LOGIC);
end timer;

architecture arch of timer is
    signal counter : integer range 0 to LIMIT;
    --type timer_state_type is (IDLE, COUNTING, TIMEOUT);
    --signal timer_state : timer_state_type;
begin
    process (clk, rst)
    begin
        if rst = '1' then
            counter <= 0;
            timer_q <= '0';
        elsif rising_edge(clk) then
            if start = '1' then
                if counter < LIMIT then
                    counter <= counter + 1;
                    timer_q <= not MODE;
                else
                    counter <= 0;
                    timer_q <= MODE;
                end if;
            else
                counter <= 0;
                timer_q <= '0';
            end if;
        end if;
    end process;
-- Reset state machine and counter


end arch;
