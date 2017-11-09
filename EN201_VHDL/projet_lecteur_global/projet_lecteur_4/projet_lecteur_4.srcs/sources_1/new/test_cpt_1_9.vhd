----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.09.2017 12:01:01
-- Design Name: 
-- Module Name: test_cpt_1_9 - Behavioral
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

entity test_cpt_1_9 is
end test_cpt_1_9;

architecture workbench_cpt_1_9 of test_cpt_1_9 is

    component cpt_1_9 is
        Port ( INCR : in STD_LOGIC;
               CLOCK : in STD_LOGIC;
               DECR : in STD_LOGIC;
               RESET : in STD_LOGIC;
               SORTIE : out STD_LOGIC_VECTOR (3 downto 0));
    end component;

    signal incr : STD_LOGIC;
    signal clock : STD_LOGIC;
    signal decr : STD_LOGIC;
    signal reset : STD_LOGIC;
    signal sortie : STD_LOGIC_VECTOR (3 downto 0);
    
    constant period : time := 10ns;

begin

    instance_cpt_1_9 :  cpt_1_9
      port map (
        incr => INCR,
        clock => CLOCK,
        decr => DECR,
        reset => RESET,
        sortie => SORTIE
        );
        
     clock_Process : process
     begin
        clock <= '1';
        wait for period/2;
        clock <= '0';
        wait for period/2;
     end process clock_Process;
     
     stimuli : process
     begin
     
        -- init
        reset <= '1';
        incr <= '0';
        decr <= '0';
        wait for 15ns;
        
        -- incrementation
        
        reset <= '0';
        incr <= '1';
        decr <= '0';
        wait for 10*period;
        
        --decrementation
        
        reset <= '0';
        incr <= '0';
        decr <= '1';
        wait for 10*period;
        
     end process stimuli;        
        




end workbench_cpt_1_9;
