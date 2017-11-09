----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.09.2017 10:54:53
-- Design Name: 
-- Module Name: transcodeur - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

package affichage is
    constant ZERO : STD_LOGIC_VECTOR (6 downto 0) := "1000000";   
    constant UN : STD_LOGIC_VECTOR (6 downto 0) := "1111001";
    constant DEUX : STD_LOGIC_VECTOR (6 downto 0) := "0100100";
    constant TROIS : STD_LOGIC_VECTOR (6 downto 0) := "0110000";
    constant QUATRE : STD_LOGIC_VECTOR (6 downto 0) := "0011001";
    constant CINQ : STD_LOGIC_VECTOR (6 downto 0) := "0010010";
    constant SIX : STD_LOGIC_VECTOR (6 downto 0) := "0000010";
    constant SEPT : STD_LOGIC_VECTOR (6 downto 0) := "1111000";
    constant HUIT : STD_LOGIC_VECTOR (6 downto 0) := "0000000";
    constant NEUF : STD_LOGIC_VECTOR (6 downto 0) := "0010000";
    constant ERREUR : STD_LOGIC_VECTOR (6 downto 0) := "0000110";
    constant OUVRANT : STD_LOGIC_VECTOR (6 downto 0) := "1000110";
    constant TIRET : STD_LOGIC_VECTOR (6 downto 0) := "0111111";
    constant FERMANT : STD_LOGIC_VECTOR (6 downto 0) := "1110000";
end;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.affichage.ALL;

entity transcodeur is
    Port ( FORWARD : in STD_LOGIC;
           PLAY_PAUSE : in STD_LOGIC;
           RESTART : in STD_LOGIC;
           nb_binaire : in STD_LOGIC_VECTOR (9 downto 0);
           nb_binaire_vol : in STD_LOGIC_VECTOR (3 downto 0);
           centaines : out STD_LOGIC_VECTOR (6 downto 0);
           dizaines : out STD_LOGIC_VECTOR (6 downto 0);
           unites : out STD_LOGIC_VECTOR (6 downto 0);
           unites_vol : out STD_LOGIC_VECTOR (6 downto 0);
           carac1 : out STD_LOGIC_VECTOR (6 downto 0);
           carac2 : out STD_LOGIC_VECTOR (6 downto 0);
           carac3 : out STD_LOGIC_VECTOR (6 downto 0);
           carac4 : out STD_LOGIC_VECTOR (6 downto 0));
end transcodeur;

architecture Behavioral of transcodeur is

signal nombre_binaire : integer range 0 to 599;

begin

    nombre_binaire <= TO_INTEGER(UNSIGNED(nb_binaire));

    carac : process (FORWARD, PLAY_PAUSE, RESTART)
    begin
        if (FORWARD = '0' and PLAY_PAUSE = '0' and RESTART = '1') then
            carac1 <= OUVRANT; -- [
            carac2 <= TIRET; -- -
            carac3 <= TIRET; -- -
            carac4 <= FERMANT; -- ]
        elsif (FORWARD = '0' and PLAY_PAUSE = '1' and RESTART = '0') then
            carac1 <= TIRET; -- -
            carac2 <= TIRET; -- -
            carac3 <= TIRET; -- -
            carac4 <= FERMANT; -- ]
        elsif (FORWARD = '1' and PLAY_PAUSE = '1' and RESTART = '0') then
            carac1 <= OUVRANT; -- [
            carac2 <= TIRET; -- -
            carac3 <= TIRET; -- -
            carac4 <= TIRET; -- -
        elsif (FORWARD = '0' and PLAY_PAUSE = '0' and RESTART = '0') then
            carac1 <= TIRET; -- -
            carac2 <= TIRET; -- -
            carac3 <= TIRET; -- -
            carac4 <= TIRET; -- -
        end if;
    end process carac;
    
    nb_vol : process (nb_binaire_vol)
    begin
        case nb_binaire_vol is
            when "0000" => unites_vol <= UN; -- 1
            when "0001" => unites_vol <= DEUX; -- 2
            when "0010" => unites_vol <= TROIS; -- 3
            when "0011" => unites_vol <= QUATRE; -- 4
            when "0100" => unites_vol <= CINQ; -- 5
            when "0101" => unites_vol <= SIX; -- 6
            when "0110" => unites_vol <= SEPT; -- 7
            when "0111" => unites_vol <= HUIT; -- 8
            when "1000" => unites_vol <= NEUF; -- 9
            when others => unites_vol <= ERREUR; -- E
        end case;
    end process nb_vol;
    
    decompo : process (nombre_binaire)
    variable cent : integer range 0 to 5 := 0;
    variable diz : integer range 0 to 9 := 0;
    variable uni : integer range 0 to 9 := 0;
    begin
        cent := nombre_binaire/100;
        diz := (nombre_binaire - (cent * 100))/10;
        uni := nombre_binaire - (cent * 100) - (diz * 10);
        case cent is
            when 0 => centaines <= ZERO; -- 0
            when 1 => centaines <= UN; -- 1
            when 2 => centaines <= DEUX; -- 2
            when 3 => centaines <= TROIS; -- 3
            when 4 => centaines <= QUATRE; -- 4
            when 5 => centaines <= CINQ; -- 5
            when others => centaines <= ERREUR; -- E
        end case;
        case diz is
            when 0 => dizaines <= ZERO; -- 0
            when 1 => dizaines <= UN; -- 1
            when 2 => dizaines <= DEUX; -- 2
            when 3 => dizaines <= TROIS; -- 3
            when 4 => dizaines <= QUATRE; -- 4
            when 5 => dizaines <= CINQ; -- 5
            when 6 => dizaines <= SIX; -- 6
            when 7 => dizaines <= SEPT; -- 7
            when 8 => dizaines <= HUIT; -- 8
            when 9 => dizaines <= NEUF; -- 9
            when others => dizaines <= ERREUR; -- E
        end case;
        case uni is
            when 0 => unites <= ZERO; -- 0
            when 1 => unites <= UN; -- 1
            when 2 => unites <= DEUX; -- 2
            when 3 => unites <= TROIS; -- 3
            when 4 => unites <= QUATRE; -- 4
            when 5 => unites <= CINQ; -- 5
            when 6 => unites <= SIX; -- 6
            when 7 => unites <= SEPT; -- 7
            when 8 => unites <= HUIT; -- 8
            when 9 => unites <= NEUF; -- 9
            when others => unites <= ERREUR; -- E    
        end case;
    end process decompo;
end Behavioral;
