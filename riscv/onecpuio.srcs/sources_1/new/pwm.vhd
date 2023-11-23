----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/23/2023 10:42:57 AM
-- Design Name: 
-- Module Name: pwm - arch
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


library ieee;
use ieee.std_logic_1164.all;

entity pwm_fsm is
    port(
        clk, rst: in std_logic;
        pwm_in: in std_logic;
        pwm_start, pwm_stop, pwm_read: in std_logic;  -- Control signals from control entity
        clear, count, load: out std_logic  -- Signals to external counter/processing unit
    );
end pwm_fsm;

architecture arch of pwm_fsm is
    type state_type is (idle, counting, loading);
    signal st_reg, st_next: state_type;

begin
    -- State register
    process(clk, rst)
    begin
        if rst = '1' then
            st_reg <= idle;
        elsif rising_edge(clk) then
            st_reg <= st_next;
        end if;
    end process;

    -- Next-state/output logic
    process(st_reg, pwm_in, pwm_start, pwm_stop, pwm_read)
    begin
        -- Default actions
        st_next <= st_reg;
        clear <= '0';
        count <= '0';
        load <= '0';

        case st_reg is
            when idle =>
                clear <= '1';
                if pwm_start = '1' and pwm_in = '1' then
                    st_next <= counting;
                end if;

            when counting =>
                count <= '1';
                if pwm_stop = '1' or (pwm_read = '1' and pwm_in = '0') then
                    st_next <= loading;
                end if;

            when loading =>
                load <= '1';
                st_next <= idle;
        end case;
    end process;
end arch;