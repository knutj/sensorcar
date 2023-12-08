----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/08/2023 02:41:04 PM
-- Design Name: 
-- Module Name: echo - Behavioral
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


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity echo is
    generic(
        PCDATA_WIDTH: integer := 8;  -- Program Counter Data Width
        IMADDR_WIDTH: integer := 5;  -- Instruction Memory Address Width
        IMDATA_WIDTH: integer := 24; -- Instruction Memory Data Width
        DRADDR_WIDTH: integer := 3;  -- Data Register Address Width
        DRDATA_WIDTH: integer := 8;  -- Data Register Data Width
        DMADDR_WIDTH: integer := 8;  -- Data Memory Address Width
        DMDATA_WIDTH: integer := 8;  -- Data Memory Data Width
        OPCODE_WIDTH: integer := 7   -- Opcode Width    
   );
      port ( echo :in  std_logic;
             echo_out: out std_logic_vector(DRDATA_WIDTH-1 downto 0);
             rst : in  std_logic;
             above : in std_logic;
             clk : in std_logic
       );
end echo;

architecture arch of echo is

begin
    echo_out <= (others => '1') when echo = '1' else
                (others => '0'); -- or some other default value
end arch;
