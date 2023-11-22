----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/22/2023 05:32:36 AM
-- Design Name: 
-- Module Name: pwm - Behavioral
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

-- https://vhdlwhiz.com/pwm-controller/

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity limit_checker is
    Port ( clk             : in  std_logic;
           reset           : in  std_logic;
           threshold_limit : in  std_logic_vector(19 downto 0);
           write_limit     : in  std_logic;
           PWM_in          : in  std_logic_vector(15 downto 0);
           above_limit     : out std_logic);
end limit_checker;

architecture Behavioral of limit_checker is
    signal counter       : unsigned(7 downto 0) := (others => '0');
    signal hold_register : std_logic_vector(15 downto 0);
    signal threshold_reg : std_logic_vector(19 downto 0);
begin
    -- Up Counter
    process(clk, reset)
    begin
        if reset = '1' then
            counter <= (others => '0');
        elsif rising_edge(clk) then
            counter <= counter + 1;
        end if;
    end process;

    -- Hold Register
    hold_register <= PWM_in when rising_edge(clk);

    -- Threshold Register
    threshold_reg <= threshold_limit when rising_edge(clk);

    -- Comparator Logic
    process(counter, hold_register, threshold_reg, write_limit)
    begin
        if unsigned(hold_register) > unsigned(threshold_reg) and write_limit = '1' then
            above_limit <= '1';
        else
            above_limit <= '0';
        end if;
    end process;
end Behavioral;

