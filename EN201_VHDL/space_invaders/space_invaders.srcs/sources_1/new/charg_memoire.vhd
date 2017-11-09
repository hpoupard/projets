----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.11.2017 11:38:42
-- Design Name: 
-- Module Name: charg_memoire - Behavioral
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

entity charg_memoire is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           addr : out STD_LOGIC_VECTOR (18 downto 0);
           data : out STD_LOGIC_VECTOR (5 downto 0);
           data_write : out STD_LOGIC);
end charg_memoire;

architecture Behavioral of charg_memoire is

signal compteur : unsigned (15 downto 0);
signal s_addr : unsigned (18 downto 0);
signal s_red, s_green, s_blue : unsigned (1 downto 0);

begin

    synchrone : process(clk)
    begin
        if (rising_edge(clk)) then
            if reset = '1' then
                compteur <= to_unsigned(0, 16);
                s_addr <= to_unsigned(0, 19);
                s_red <= to_unsigned(0, 2);
                s_green <= to_unsigned(0, 2);
                s_blue <= to_unsigned(0, 2);
                data_write <= '0';
            elsif compteur = 65535 then
                compteur <= to_unsigned(0, 16);
                s_addr <= s_addr + 1;
                s_red <= s_red + 1;
                data_write <= '1';
            else
                compteur <= compteur + 1;
                data_write <= '0';
            end if;
        end if;
    end process synchrone;
    
    addr <= STD_LOGIC_VECTOR(s_addr);
    data <= STD_LOGIC_VECTOR(s_red) & STD_LOGIC_VECTOR(s_green) & STD_LOGIC_VECTOR(s_blue);
    
end Behavioral;
