library ieee;
use ieee.std_logic_1164.all;

entity trig_counter is
    port (
        clk         : in    std_logic;
        rst         : in    std_logic;
        start       : in    std_logic;
        trig        : out   std_logic
    );
end trig_counter;

architecture arch of trig_counter is
    constant TRIG_LIMIT : integer := 500;       -- 500 cycles = 5us
    constant WAIT_LIMIT : integer := 10000000;  -- 10m cycles = 100ms
    
    signal trig_counter : integer range 0 to TRIG_LIMIT := 0;     
    signal wait_counter : integer range 0 to WAIT_LIMIT := 0; 
    signal trig_active  : boolean                       := true;
    
begin
    process (clk, rst)
    begin
        if rst = '1' then
            trig_counter <= 0;
            wait_counter <= 0;
            trig_active <= true;
            trig <= '0';
            
        elsif rising_edge(clk) then
            if start = '1' then
                if trig_active then
                    trig <= '1';
                    trig_counter <= trig_counter + 1;
                    if trig_counter = TRIG_LIMIT then
                        trig_counter <= 0;
                        trig_active <= false;
                        trig <= '0';
                    end if;
                    
                else
                    wait_counter <= wait_counter + 1;
                    if wait_counter = WAIT_LIMIT then
                        wait_counter <= 0;
                        trig_active <= true;
                    end if;
                end if;
            else 
                trig <= '0';
            end if;
        end if;
    end process;
end arch;
