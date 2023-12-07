----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/07/2023 07:21:09 PM
-- Design Name: 
-- Module Name: up_counter - arch
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


-- Import the IEEE library for standard logic components and numeric operations
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.constants_pkg.all;  -- Import custom package for constants

-- Define an entity named 'up_counter' for an up-counter module
entity up_counter is
    -- Define generic parameter to specify the data width of the counter
    generic(
        DRDATA_WIDTH: integer := 8  -- Data Register Data Width (default 8 bits)
    );
    -- Define input and output ports for the entity
    port(
        clk: in std_logic;     -- Clock input signal
        rst: in std_logic;     -- Reset input signal
        uc_clr: in std_logic;  -- Clear input signal (resets counter when high)
        uc_cnt: in std_logic;  -- Count input signal (increments counter when high)
        uc_q: out std_logic_vector(DRDATA_WIDTH - 1 downto 0) -- Counter output (vector)
    );
end up_counter;

-- Architecture definition of the 'up_counter' entity
architecture arch of up_counter is
    -- Internal signals to hold the current and next counter values
    signal r_reg: unsigned(DRDATA_WIDTH - 1 downto 0);  -- Current counter value
    signal r_next: unsigned(DRDATA_WIDTH - 1 downto 0); -- Next counter value

begin
    -- Define a sequential process triggered by changes in 'clk' and 'rst'
    process(clk, rst)
    begin
        -- If reset is high ('1'), then clear the counter
        if rst = '1' then
            r_reg <= (others => '0');  -- Set counter to zero
        -- If a rising edge on the clock signal is detected
        elsif rising_edge(clk) then
            r_reg <= r_next;  -- Update counter with next value
        end if;
    end process;

    -- Logic to determine the next counter value
    r_next <=
        r_reg + 1       when uc_cnt = '1' else  -- Increment counter when 'uc_cnt' is high
        (others => '0') when uc_clr = '1' else  -- Reset counter to zero when 'uc_clr' is high
        r_reg;  -- Maintain current value otherwise
    
    -- Output the current counter value
    uc_q <= std_logic_vector(r_reg);  -- Convert unsigned counter value to std_logic_vector
    
end arch;
