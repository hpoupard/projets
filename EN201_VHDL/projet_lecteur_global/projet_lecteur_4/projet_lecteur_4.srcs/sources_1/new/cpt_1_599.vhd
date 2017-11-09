----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.09.2017 09:54:19
-- Design Name: 
-- Module Name: cpt_1_599 - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity cpt_1_599 is
    Port ( INIT : in STD_LOGIC;
           RESET : in STD_LOGIC;
           CLOCK : in STD_LOGIC;
           CE_AFFICHAGE : in STD_LOGIC;
           DECR : in STD_LOGIC;
           INCR : in STD_LOGIC;
           SORTIE : out STD_LOGIC_VECTOR (9 downto 0));
end cpt_1_599;

architecture Behavioral of cpt_1_599 is

signal compteur_599 : natural range 1 to 599;

begin

    compteur_1_599 : process (CLOCK)
    begin
        if rising_edge(CLOCK) then
            if RESET = '1' then
                compteur_599 <= 1;
            elsif INIT = '1' then
                compteur_599 <= 1;
            elsif CE_AFFICHAGE = '1' then
                if INCR = '1' then
                    if compteur_599 = 599 then
                        compteur_599 <= compteur_599;
                    else
                        compteur_599 <= compteur_599 + 1;
                    end if;
                elsif DECR = '1' then
                    if compteur_599 = 1 then
                        compteur_599 <= compteur_599;
                    else
                        compteur_599 <= compteur_599 - 1;
                    end if;
                end if;
            end if;
        end if;
    end process compteur_1_599;
    
    SORTIE <= STD_LOGIC_VECTOR(TO_UNSIGNED(compteur_599, 10));
    
end Behavioral;
