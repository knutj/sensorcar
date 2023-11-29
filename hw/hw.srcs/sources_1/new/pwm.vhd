library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity limit_checker is
    Port ( clk             : in  std_logic;
           reset           : in  std_logic;
           threshold_limit : in  std_logic_vector(19 downto 0);
           write_limit     : in  std_logic;
           PWM_in          : in  std_logic_vector(19 downto 0);
           above_limit     : in  std_logic;
           pwm_out         : out std_logic);
end limit_checker;


architecture Behavioral of limit_checker is
    type state_type is (S0, S1);
    signal current_state : state_type := S0;
    signal counter       : unsigned(19 downto 0) := (others => '0');  -- Changed to 20 bits
    signal hold_register : std_logic_vector(19 downto 0);
    signal threshold_reg : std_logic_vector(19 downto 0);
    signal last_PWM_in   : std_logic_vector(19 downto 0) := (others => '0');

begin
    -- Up Counter and State Machine Logic
    process(clk, reset)
    begin
        if reset = '1' then
            counter <= (others => '0');
            current_state <= S0;
            last_PWM_in <= (others => '0');
        elsif rising_edge(clk) then
            -- Detect rising and falling edges of PWM_in
            if PWM_in /= last_PWM_in then
                if PWM_in = "00000000000000000001" and last_PWM_in = "00000000000000000000" then
                    -- Rising edge detected
                    counter <= (others => '0');  -- Clear and start counter
                elsif PWM_in = "00000000000000000000" and last_PWM_in = "00000000000000000001" then
                    -- Falling edge detected
                    hold_register <= std_logic_vector(counter);  -- Copy counter to hold_register
                end if;
                last_PWM_in <= PWM_in;
            end if;

            -- State machine logic
            case current_state is
                when S0 =>
                    if above_limit = '1' then
                        current_state <= S1;
                    end if;
                when S1 =>
                    if above_limit = '0' then
                        current_state <= S0;
                    else
                        counter <= counter + 1;
                    end if;
            end case;
        end if;
    end process;

    -- Rest of the code remains the same
end Behavioral;