----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/05/2023 09:51:09 AM
-- Design Name: 
-- Module Name: timer_n - Behavioral
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

library ieee;
use ieee.std_logic_1164.all;

entity timer_n is
    generic (
        LIMIT   : integer;
        MODE    : std_logic := '1' -- Mode: '0' for echo trigger
    );
    port (
        clk     : in    std_logic;
        rst     : in    std_logic;
        start   : in    std_logic;
        timer_q : out   std_logic
    );
end timer_n;

architecture arch of timer is
    signal counter : integer range 0 to LIMIT;
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
end arch;

