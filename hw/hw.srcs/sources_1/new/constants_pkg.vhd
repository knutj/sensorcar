library ieee;
use ieee.std_logic_1164.all;

package constants_pkg is
    constant MOTOR_WIDTH        : integer := 9;
    constant SENSOR_WIDTH       : integer := 20;
    constant AN_WIDTH           : integer := 4;
    constant SEG_WIDTH          : integer := 8;
    
    -- Segments are represented via 8 bits in the order (dp, g, f, e, d, c, b, a) where each letter is a line in the number on the display
    -- To form a 0, all lines except the middle must be set to 1, and there is no decimal point
    --   --a--
    -- f|     |b
    --   --g--
    -- e|     |c
    --   --d--   dp
    type seven_segment_lookup_table is array(0 to 9) of std_logic_vector(7 downto 0);
    constant SEG7_LUT : seven_segment_lookup_table := (
        "00111111",  -- 0
        "00000110",  -- 1
        "01011011",  -- 2
        "01001111",  -- 3
        "01100110",  -- 4
        "01101101",  -- 5
        "01111101",  -- 6
        "00000111",  -- 7
        "01111111",  -- 8
        "01101111"   -- 9
    ); 
end package constants_pkg;
