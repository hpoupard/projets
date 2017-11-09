----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.09.2017 10:09:12
-- Design Name: 
-- Module Name: gestion_freq - Behavioral
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

entity gestion_freq is
    Port ( CLOCK : in STD_LOGIC;
           RESET : in STD_LOGIC;
           CE_AFFICHAGE : out STD_LOGIC;
           CE_PERCEPTION : out STD_LOGIC);
end gestion_freq;

architecture Behavioral of gestion_freq is

signal compteur_perception : natural range 0 to 33332;
signal compteur_affichage : natural range 0 to 9999999;

begin

clock_affichage : process (CLOCK)
begin
    if rising_edge(CLOCK) then
        if RESET = '1' then
            compteur_affichage <= 0;
            CE_AFFICHAGE <= '0';
        elsif compteur_affichage = 9999999 then
            compteur_affichage <= 0;
            CE_AFFICHAGE <= '1';
        else
            compteur_affichage <= compteur_affichage + 1;
            CE_AFFICHAGE <= '0';
        end if;
    end if;
end process clock_affichage;

clock_perception : process (CLOCK)
begin
    if rising_edge(CLOCK) then
        if RESET = '1' then
            compteur_perception <= 0;
            CE_PERCEPTION <= '0';
        elsif compteur_perception = 33332 then
            compteur_perception <= 0;
            CE_PERCEPTION <= '1';
        else
            compteur_perception <= compteur_perception + 1;
            CE_PERCEPTION <= '0';
        end if;
    end if;
end process clock_perception;

end Behavioral;
