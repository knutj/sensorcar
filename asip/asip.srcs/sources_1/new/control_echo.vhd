library ieee;
use ieee.std_logic_1164.all;

entity control_echo is
    port (
        clk     : in    std_logic;
        rst     : in    std_logic;
        echo    : in    std_logic;
        clr     : out   std_logic;
        cnt     : out   std_logic;
        ld      : out   std_logic
    );
end control_echo;

architecture arch of control_echo is
    type state_type is (s0, s1);
    signal st_reg   : state_type;
    signal st_next  : state_type;
begin
    process (clk, rst)
    begin
        if rst = '1' then
            st_reg <= s0;
        elsif rising_edge(clk) then
            st_reg <= st_next;
        end if;
    end process;

    process (st_reg, echo)
    begin
        st_next <= st_reg;
        clr     <= '0';
        cnt     <= '0';
        ld      <= '0';
        
        
        case st_reg is
            when s0 =>
                clr <= '1';
                if echo = '1' then
                    st_next <= s1;
                end if;
            
            when s1 =>
                cnt <= '1';
                if echo = '0' then
                    ld <= '1';
                    st_next <= s0;
                end if;
        end case;
    end process;
end arch;
