----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.09.2017 11:46:53
-- Design Name: 
-- Module Name: cpt_1_9 - Behavioral
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

entity cpt_1_9 is
    Port ( INCR : in STD_LOGIC;
           CLOCK : in STD_LOGIC;
           DECR : in STD_LOGIC;
           RESET : in STD_LOGIC;
           SORTIE : out STD_LOGIC_VECTOR (3 downto 0));
end cpt_1_9;

architecture Behavioral of cpt_1_9 is

    signal compteur : natural range 0 to 8;

begin

    compteur_1_9 : process (CLOCK)
    begin
        if rising_edge(CLOCK) then
            if RESET = '1' then
                compteur <= 0;
            elsif INCR = '1' and compteur < 8 then
                compteur <= compteur + 1;
            elsif DECR = '1' and compteur > 0 then
                compteur <= compteur - 1;
            end if;
        end if;
    end process compteur_1_9;
                
    SORTIE <= STD_LOGIC_VECTOR(TO_UNSIGNED(compteur, 4));

end Behavioral;
