library ieee;
use ieee.std_logic_1164.all;
use work.constants_pkg.all;

entity control_car is
    port (
        clk         : in    std_logic;
        rst         : in    std_logic;
        en          : in    std_logic;
        above_limit : in    std_logic;
        done_bw     : in    std_logic;
        done_tl     : in    std_logic;
        
        mot_en      : out   std_logic;
        mot_lfw     : out   std_logic;
        mot_rfw     : out   std_logic;
        start_bw    : out   std_logic;
        start_tl    : out   std_logic
    );
end control_car;

architecture arch of control_car is
    type state_type is (s0, s1, s2, s3);
    signal st_reg, st_next : state_type;
    
begin
    process (clk, rst)
    begin
        if rst = '1' then
            st_reg <= s0;
        elsif rising_edge(clk) then
            st_reg <= st_next;
        end if;
    end process;

    process (st_reg, en, above_limit, done_bw, done_tl)
    begin
        st_next     <= st_reg;
        mot_en      <= '0';
        mot_lfw     <= '0';
        mot_rfw     <= '0';
        start_bw    <= '0';
        start_tl    <= '0';
        
        case st_reg is
            when s0 =>
                if en = '1' then
                    st_next <= s1;
                end if;
                
            when s1 =>
                mot_en <= '1';
                mot_lfw <= '1';
                mot_rfw <= '1';
                
                if en = '0' then
                    st_next <= s0;
                elsif above_limit = '1' then
                    st_next <= s2;
                end if;
 
            when s2 =>
                mot_en <= '1';
                start_bw <= '1';
                
                if en = '0' then
                    st_next <= s0;
                elsif done_bw = '1' then
                    start_bw <= '0';
                    st_next <= s3;
                end if;

            when s3 =>
                mot_en <= '1';
                mot_rfw <= '1';
                start_tl <= '1';
                
                if en = '0' then
                    st_next <= s0;
                elsif done_tl = '1' then
                    start_tl <= '0';
                    st_next <= s1;
                end if;

        end case;
    end process;
end arch;
