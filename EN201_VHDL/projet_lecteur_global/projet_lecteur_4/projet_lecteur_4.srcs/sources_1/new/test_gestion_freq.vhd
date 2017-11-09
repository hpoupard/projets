----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.09.2017 11:16:40
-- Design Name: 
-- Module Name: test_gestion_freq - Behavioral
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

entity test_gestion_freq is
end test_gestion_freq;

architecture workbench_gest_freq of test_gestion_freq is

component gestion_freq is
    Port ( CLOCK : in STD_LOGIC;
           RESET : in STD_LOGIC;
           CE_AFFICHAGE : out STD_LOGIC;
           CE_PERCEPTION : out STD_LOGIC);
end component;

signal clock : STD_LOGIC := '0';
signal reset : STD_LOGIC := '0';
signal ce_affichage : STD_LOGIC := '0';
signal ce_perception : STD_LOGIC := '0';

constant period : time := 10ns;

begin

instance_gest_freq :  gestion_freq
  port map (
    clock => CLOCK,
        reset => RESET,
        ce_affichage => CE_AFFICHAGE,
        ce_perception => CE_PERCEPTION
        );

clock_Process : process
      begin
        clock <= '1';
        wait for period/2;
        clock <= '0';
        wait for period/2;
      end process clock_Process;

end workbench_gest_freq;
