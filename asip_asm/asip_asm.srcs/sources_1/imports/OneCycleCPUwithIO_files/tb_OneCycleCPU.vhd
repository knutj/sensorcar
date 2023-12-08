--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY tb_OneCycleCPUwithIO IS
   generic(
      DRDATA_WIDTH: integer:=8      
   );
END tb_OneCycleCPUwithIO;
 
ARCHITECTURE behavior OF tb_OneCycleCPUwithIO IS 
 
    -- Component Declaration for the Unit Under Test (UUT) 
    COMPONENT OneCycleCPUwithIO
    PORT(clk, rst: in std_logic;
         dig_in: in std_logic_vector(DRDATA_WIDTH-1 downto 0);
         dig_out: out std_logic_vector(DRDATA_WIDTH-1 downto 0) );
    END COMPONENT;
    
   --Inputs
   signal clk : std_logic;
   signal rst : std_logic;
   signal dig_in: std_logic_vector(DRDATA_WIDTH-1 downto 0);
 	--Outputs
   signal dig_out: std_logic_vector(DRDATA_WIDTH-1 downto 0);
   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: OneCycleCPUwithIO PORT MAP (
          clk => clk,
          rst => rst, 
          dig_in => dig_in );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      rst <= '1';
      wait for clk_period;	
	  rst <= '0';
	  dig_in <= "01010101";
	  wait for clk_period*64;
   end process;

END;
