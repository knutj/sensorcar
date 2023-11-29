library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Ultrasonic_Sensor is
    Port (
        clk         : in  std_logic;
        reset       : in  std_logic;
        trig_pulse  : in  std_logic;
        echo        : in  std_logic;
        trig        : out std_logic;
        distance    : out unsigned(31 downto 0)
    );
end Ultrasonic_Sensor;

architecture arch of Ultrasonic_Sensor is
    signal echo_duration : unsigned(15 downto 0);
    signal trigger_timer : unsigned(15 downto 0);
    signal state         : std_logic := '0';
    constant CONSTANT_FACTOR : unsigned(15 downto 0) := to_unsigned(100, 16); -- Example scaling factor
begin
    -- Trigger process
    trig <= '1' when trigger_timer < "0000000000001000" else '0'; -- Trigger pulse for 10us

    -- Main process
    process(clk, reset)
    begin
        if reset = '1' then
            trigger_timer <= (others => '0');
            echo_duration <= (others => '0');
            state <= '0';
        elsif rising_edge(clk) then
            -- Trigger timer
            if trig_pulse = '1' then
                trigger_timer <= trigger_timer + 1;
            else
                trigger_timer <= (others => '0');
            end if;

            -- Echo duration measurement
            case state is
                when '0' =>
                    if echo = '1' then
                        state <= '1';
                        echo_duration <= (others => '0');
                    end if;
                when '1' =>
                    if echo = '1' then
                        echo_duration <= echo_duration + 1;
                    else
                        state <= '0';
                    end if;
                when others =>
                    state <='0';
            end case;
        end if;
    end process;

    -- Distance calculation
    distance <= echo_duration * CONSTANT_FACTOR;
end arch;