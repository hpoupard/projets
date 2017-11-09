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

signal net_perception, net_affichage : STD_LOGIC;
signal compteur_perception : natural range 0 to 33332;
signal compteur_affichage : natural range 0 to 9999999;

begin

clock_affichage : process (CLOCK)
variable tempo : integer range 0 to 1;
begin
    if rising_edge(CLOCK) then
        if RESET = '1' then
            compteur_affichage <= 0;
            net_affichage <= '0';
            tempo := 0;
        elsif compteur_affichage = 33332 then
            compteur_affichage <= 0;
            net_affichage <= '1';
            tempo := 1;
        elsif tempo = 1 then
            compteur_affichage <= compteur_affichage;
            net_affichage <= '1';
            tempo := 0;
        else
            compteur_affichage <= compteur_affichage + 1;
            net_affichage <= '0';
        end if;
    end if;
end process clock_affichage;

clock_perception : process (CLOCK)
variable tempo2 : integer range 0  to 1;
begin
    if rising_edge(CLOCK) then
        if RESET = '1' then
            compteur_perception <= 0;
            net_perception <= '0';
            tempo2 := 0;
        elsif compteur_perception = 9999999 then
            compteur_perception <= 0;
            net_perception <= '1';
            tempo2 := 1;
        elsif tempo2 = 1 then
            compteur_perception <= compteur_perception;
            net_perception <= '1';
            tempo2 := 0;
        else
            compteur_perception <= compteur_perception + 1;
            net_perception <= '0';
        end if;
    end if;
end process clock_perception;

    CE_PERCEPTION <= net_perception;
    CE_AFFICHAGE <= net_affichage;

end Behavioral;
