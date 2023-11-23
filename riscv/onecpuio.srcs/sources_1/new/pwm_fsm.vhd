library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;  -- For using 'unsigned' type

entity pwm_fsm is
    port(
        clk, rst: in std_logic;
        distance: in unsigned(15 downto 0);  -- Distance measurement input
        threshold: in unsigned(15 downto 0); -- Threshold value input
        pwm_in, pwm_start, pwm_stop, pwm_read: in std_logic;  -- Control signals
        clear, count, load, pwm_out: out std_logic  -- Output signals
    );
end pwm_fsm;

architecture arch of pwm_fsm is
    type state_type is (idle, counting, loading);
    signal st_reg, st_next: state_type;
    signal below_threshold: std_logic;  -- Signal to indicate if distance is below threshold
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

    -- Determine if distance is below the threshold
    below_threshold <= '1' when distance < threshold else '0';

    -- Next-state/output logic
    process(st_reg, pwm_in, below_threshold, pwm_start, pwm_stop, pwm_read)
    begin
        -- Default actions
        st_next <= st_reg;
        clear <= '0';
        count <= '0';
        load <= '0';
        pwm_out <= '0';

        case st_reg is
            when idle =>
                clear <= '1';
                if pwm_start = '1' and below_threshold = '1' then
                    st_next <= counting;
                end if;

            when counting =>
                count <= '1';
                if pwm_stop = '1' or (pwm_read = '1' and pwm_in = '0') then
                    st_next <= loading;
                end if;

            when loading =>
                load <= '1';
                pwm_out <= '1';  -- Optionally set pwm_out based on your requirement
                st_next <= idle;
        end case;
    end process;
end arch;
