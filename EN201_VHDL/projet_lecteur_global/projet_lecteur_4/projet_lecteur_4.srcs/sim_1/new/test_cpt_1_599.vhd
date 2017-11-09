----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.09.2017 09:52:15
-- Design Name: 
-- Module Name: test_cpt_1_599 - Behavioral
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

entity test_cpt_1_599 is
end test_cpt_1_599;

architecture workbench_cpt_1_599 of test_cpt_1_599 is

    component cpt_1_599 is
        Port ( INIT : in STD_LOGIC;
               RESET : in STD_LOGIC;
               CLOCK : in STD_LOGIC;
               CE_AFFICHAGE : in STD_LOGIC;
               DECR : in STD_LOGIC;
               INCR : in STD_LOGIC;
               SORTIE : out STD_LOGIC_VECTOR (9 downto 0));
    end component cpt_1_599;

    signal init : STD_LOGIC;
    signal reset : STD_LOGIC;
    signal clock : STD_LOGIC;
    signal ce_affichage : STD_LOGIC;
    signal decr : STD_LOGIC;
    signal incr : STD_LOGIC;
    signal sortie : STD_LOGIC_VECTOR(9 downto 0);
    
    constant period_clock : time := 10ns;
    constant period_ce_affichage : time := 100ms;

begin

    instance_cpt_1_599 : cpt_1_599
    port map (
        init => INIT,
        reset => RESET,
        clock => CLOCK,
        ce_affichage => CE_AFFICHAGE,
        decr => DECR,
        incr => INCR,
        sortie => SORTIE
        );

    clock_Process : process
     begin
        clock <= '1';
        wait for period_clock/2;
        clock <= '0';
        wait for period_clock/2;
     end process clock_Process;
     
     ce_affichage_Process : process
          begin
             ce_affichage <= '1';
             wait for period_clock;
             ce_affichage <= '0';
             wait for period_ce_affichage;
          end process ce_affichage_Process;

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
        wait for 605*period_ce_affichage;
        
        --decrementation
        
        reset <= '0';
        incr <= '0';
        decr <= '1';
        wait for 605*period_ce_affichage;
    end process stimuli;

end workbench_cpt_1_599;
