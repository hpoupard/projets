----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.10.2017 09:49:43
-- Design Name: 
-- Module Name: horloge_44100Hz - Behavioral
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

entity horloge_44100Hz is
    Port ( CLOCK : in STD_LOGIC;
           RESET : in STD_LOGIC;
           CLK_44100 : out STD_LOGIC);
end horloge_44100Hz;

architecture Behavioral of horloge_44100Hz is

signal compteur : integer range 0 to 2266;

begin

    clock_44100 : process (CLOCK)
    begin
        if (falling_edge(CLOCK)) then
            if RESET = '1' then
                compteur <= 0;
                CLK_44100 <= '0';
            elsif compteur = 2266 then
                compteur <= 0;
                CLK_44100 <= '1';
            else
                compteur <= compteur + 1;
                CLK_44100 <= '0';
            end if;
        end if;
    end process clock_44100;

end Behavioral;
