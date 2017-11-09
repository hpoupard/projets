----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.10.2017 10:04:13
-- Design Name: 
-- Module Name: pwm - Behavioral
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

entity pwm is
    Port ( CLOCK : in STD_LOGIC;
           CE : in STD_LOGIC;
           RESET : in STD_LOGIC;
           IDATA : in STD_LOGIC_VECTOR (10 downto 0);
           ODATA : out STD_LOGIC);
end pwm;

architecture Behavioral of pwm is

    signal compteur : unsigned (11 downto 0);
    signal sdata : signed (10 downto 0);
    signal compteur_max : unsigned (10 downto 0);
    
begin

sdata <= SIGNED(IDATA);

compteur_max <= UNSIGNED(sdata + 1024);

process_synchrone : process(CLOCK)
begin
    if (rising_edge(CLOCK)) then
        if RESET = '1' then
            compteur <= TO_UNSIGNED(0, 12);
        elsif CE = '1' then
            compteur <= TO_UNSIGNED(0, 12);
        else
            compteur <= compteur + 1;
        end if;
     end if;
end process process_synchrone;

process_asynchrone : process(compteur, compteur_max)
begin
    if compteur < compteur_max then
        ODATA <= '1';
    else
        ODATA <= '0';
    end if;
end process process_asynchrone;
            
end Behavioral;
