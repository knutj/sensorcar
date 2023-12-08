library ieee;
use ieee.std_logic_1164.all;

entity timer is
    generic (
        LIMIT   : integer
    );
    port (
        clk     : in    std_logic;
        rst     : in    std_logic;
        start   : in    std_logic;
        done    : out   std_logic
    );
end timer;

architecture arch of timer is
    signal counter      : integer range 0 to LIMIT;
    signal is_running   : std_logic := '0';
    
begin
    process (clk, rst)
    begin
        if rst = '1' then
            counter <= 0;
            done <= '0';
            is_running <= '0';
        elsif rising_edge(clk) then
            if start = '1' then
                is_running <= '1';
            end if;
        
            if is_running = '1' then
                if counter < LIMIT then
                    counter <= counter + 1;
                    done <= '0';
                else
                    counter <= 0;
                    done <= '1';
                    is_running <= '0';
                end if;
            end if;
        end if;
    end process;
end arch;
