library ieee;
use ieee.std_logic_1164.all;
use work.constants_pkg.all;

entity control is
    generic (
        STOP        : std_logic_vector(MOTOR_WIDTH - 1 downto 0) := "00000000";
        FORWARD     : std_logic_vector(MOTOR_WIDTH - 1 downto 0) := "01010101";
        BACKWARD    : std_logic_vector(MOTOR_WIDTH - 1 downto 0) := "10101010";
        TURNLEFT    : std_logic_vector(MOTOR_WIDTH - 1 downto 0) := "10100101"
    );
    port (
        clk         : in    std_logic;
        rst         : in    std_logic;
        echo        : in    std_logic;
        above_limit : in    std_logic;
        timeup_bw   : in    std_logic;
        timeup_tl   : in    std_logic;
        
        clr         : out   std_logic;
        cnt         : out   std_logic;
        ld          : out   std_logic;
        motors      : out   std_logic_vector(MOTOR_WIDTH - 1 downto 0);
        start_bw    : out   std_logic;
        start_tl    : out   std_logic;
        trig        : out   std_logic;
        max_t    :    in std_logic

    );
end control;

architecture arch of control is
    type echo_type is (WAITING, MEASURING, SEND_TRIG);
    type motor_type is (IDLE, MOVE_FORWARD, MOVE_BACKWARD, TURN_LEFT);
    signal echo_reg, echo_next : echo_type;
    signal motor_reg, motor_next : motor_type;
begin
    process (clk, rst)
    begin
        if rst = '1' then
            echo_reg    <= WAITING;
            motor_reg   <= IDLE;
        elsif rising_edge(clk) then
            echo_reg    <= echo_next;
            motor_reg   <= motor_next;
        end if;
    end process;
    
    -- State machine for ECHO sensor
    process (echo_reg, echo)
    begin
        echo_next   <= SEND_TRIG;
        clr      <= '0';
        cnt      <= '0';
        ld       <= '0';
        trig     <=  '0';
        
        case echo_reg is 
           when SEND_TRIG =>
                echo_next <= WAITING; 
                if max_t = '1' then
                   trig <= '1';
                end if;
       
            when WAITING =>
                clr <= '1';
                trig <= '0';
                if echo = '1' then
                    echo_next <= MEASURING;
                end if;
                
            when MEASURING =>
                cnt <= '1';
                trig <= '0';
                if echo = '0' then
                    ld <= '1';
                    echo_next <= WAITING;
                end if;
        end case;
    end process;
    
    -- State machine for car movement
    process (motor_reg, above_limit, timeup_bw, timeup_tl)
    begin
        motor_next  <= motor_reg;
        start_bw    <= '0';
        start_tl    <= '0';
        
        case motor_reg is
            when IDLE =>
                motors <= STOP;
                motor_next <= MOVE_FORWARD;

            when MOVE_FORWARD =>
                motors <= FORWARD;
                if above_limit = '1' then
                    motor_next <= MOVE_BACKWARD;
                end if;
                
            when MOVE_BACKWARD =>
                start_bw <= '1';
                motors <= BACKWARD; 
                if timeup_bw = '1' then
                    start_bw <= '0';
                    motor_next <= TURN_LEFT;
                end if;
               
            when TURN_LEFT =>
                start_tl <= '1';
                motors <= TURNLEFT; 
                if timeup_tl = '1' then
                    start_tl <= '0';
                    motor_next <= MOVE_FORWARD;
                end if;
        end case;
    end process;
end arch;
