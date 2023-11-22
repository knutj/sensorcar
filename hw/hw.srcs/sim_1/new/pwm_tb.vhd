----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/22/2023 06:26:27 AM
-- Design Name: 
-- Module Name: pwm_tb - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

entity limit_checker_tb is
-- Testbench has no ports!
end limit_checker_tb;

architecture behavior of limit_checker_tb is 
    -- Component Declaration for the Unit Under Test (UUT)
    component limit_checker
    Port ( clk             : in  std_logic;
           reset           : in  std_logic;
           threshold_limit : in  std_logic_vector(7 downto 0);
           write_limit     : in  std_logic_vector(7 downto 0);
           PWM_in          : in  std_logic_vector(7 downto 0);
           above_limit     : out std_logic);
    end component;

    --Inputs
    signal clk             : std_logic := '0';
    signal reset           : std_logic := '0';
    signal threshold_limit : std_logic_vector(7 downto 0) := (others => '0');
    signal write_limit     : std_logic_vector(7 downto 0) := (others => '0');
    signal PWM_in          : std_logic_vector(7 downto 0) := (others => '0');

    --Outputs
    signal above_limit     : std_logic;

    -- Clock period definitions
    constant clk_period : time := 10 ns;

begin 
    -- Instantiate the Unit Under Test (UUT)
    uut: limit_checker Port Map (
          clk => clk,
          reset => reset,
          threshold_limit => threshold_limit,
          write_limit => write_limit,
          PWM_in => PWM_in,
          above_limit => above_limit
        );

    -- Clock process definitions
    clk_process :process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;

    -- Testbench statements
    stim_proc: process
    begin       
        -- Initialize Inputs
        reset <= '1';
        wait for 20 ns;
        reset <= '0';

        -- Set threshold and write limits
        threshold_limit <= "00010000"; -- 16 in decimal
        write_limit <= "00100000"; -- 32 in decimal

        -- Wait for the global reset
        wait for 40 ns;

        -- Change PWM_in and observe
        PWM_in <= "00011000"; -- 24 in decimal, should set above_limit to '1'
        wait for 20 ns;
        PWM_in <= "00001000"; -- 8 in decimal, should set above_limit to '0'
        wait for 20 ns;

        -- Add more test cases as needed

        -- Finish the simulation
        wait;
    end process;
end behavior;
