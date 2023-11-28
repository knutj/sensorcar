----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/22/2023 02:52:51 PM
-- Design Name: 
-- Module Name: motor_tb - Behavioral
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


library ieee;
use ieee.std_logic_1164.all;

entity motor_control_tb is
    -- Testbench has no ports
end entity motor_control_tb;

architecture arch of motor_control_tb is
    -- Component Declaration for the Unit Under Test (UUT)
    component motor_control
        port(
            clk         : in  std_logic;
            pwm_out     : out std_logic;
            motor_dir   : out std_logic_vector(1 downto 0)
        );
    end component;

    -- Inputs
    signal clk         : std_logic := '0';

    -- Outputs
    signal pwm_out     : std_logic;
    signal motor_dir   : std_logic_vector(1 downto 0);

    -- Clock period definition
    constant clk_period : time := 10 ns;

begin
    -- Instantiate the Unit Under Test (UUT)
    uut: motor_control
        port map (
            clk => clk,
            pwm_out => pwm_out,
            motor_dir => motor_dir
        );

    -- Clock process definitions
    clk_process: process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;

    -- Test process
    test_process: process
    begin
        -- Initialize Inputs
        -- Wait for the global reset
        wait for 100 ns;

        -- Add stimulus here
        -- Example: Test different duty cycles or observe PWM behavior

        wait; -- Will run forever
    end process;
end architecture;