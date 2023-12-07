----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/07/2023 12:58:40 PM
-- Design Name: 
-- Module Name: tb_top - Behavioral
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

-- Test bench entity (no ports)
ENTITY tb_OneCycleCPUwithIO IS
END tb_OneCycleCPUwithIO;

ARCHITECTURE behavior OF tb_OneCycleCPUwithIO IS 

    -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT OneCycleCPUwithIO
    PORT(
        clk : IN  std_logic;
        rst : IN  std_logic;
        dig_in : IN  std_logic_vector(7 downto 0);
        trig : OUT  std_logic;
        echo : IN  std_logic;
        dig_out : OUT  std_logic_vector(7 downto 0);
        m_dig_out : OUT  std_logic_vector(7 downto 0)
    );
    END COMPONENT;
   
    -- Inputs
    signal clk : std_logic := '0';
    signal rst : std_logic := '1';
    signal dig_in : std_logic_vector(7 downto 0) := (others => '0');
    signal echo : std_logic := '0';

    -- Outputs
    signal trig : std_logic;
    signal dig_out : std_logic_vector(7 downto 0);
    signal m_dig_out : std_logic_vector(7 downto 0);

    -- Clock period definition
    constant clk_period : time := 10 ns;

BEGIN 

    -- Instantiate the Unit Under Test (UUT)
    uut: OneCycleCPUwithIO PORT MAP (
          clk => clk,
          rst => rst,
          dig_in => dig_in,
          trig => trig,
          echo => echo,
          dig_out => dig_out,
          m_dig_out => m_dig_out
    );

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
        -- Reset
        wait for clk_period*10;
        rst <= '0';
        echo <= '1';
        -- Insert stimulus here e.g., set digital inputs, echo signal etc.

        -- Wait for enough time to observe the outputs
        wait for clk_period*100;
        echo <='0';
        -- Add more test cases as needed

        wait;
    end process;

END;
