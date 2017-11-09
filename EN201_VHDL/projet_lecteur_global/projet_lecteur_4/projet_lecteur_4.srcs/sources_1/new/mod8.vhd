library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity mod8 is
  port (
    CLOCK : in STD_LOGIC;
    RESET : in STD_LOGIC;
    C_PERC : in STD_LOGIC;
    AN : out STD_LOGIC_VECTOR(7 downto 0);
    sortie : out STD_LOGIC_VECTOR(2 downto 0)
  );
end mod8;

architecture Behavorial of mod8 is
  
  signal compteur : unsigned(2 downto 0) := "000";
  signal anode : STD_LOGIC_VECTOR (7 downto 0) := "01111111";
  
begin

  synchrone : process(CLOCK)
  begin
    if rising_edge(CLOCK) then
      if RESET = '1' then
        compteur <= "000";
      elsif C_PERC = '1' then
        if compteur = "111" then
            compteur <= "000";
        else
            compteur <= compteur + 1;
        end if;
     end if;
   end if;
  end process synchrone;

  asynchrone : process(compteur)
  begin
    case (compteur) is
                     when "000" => anode <= "01111111";
                     when "001" => anode <= "10111111";
                     when "010" => anode <= "11011111";
                     when "011" => anode <= "11101111";
                     when "100" => anode <= "11110111";
                     when "101" => anode <= "11111011";
                     when "110" => anode <= "11111101";
                     when "111" => anode <= "11111110";
                     when others => anode <= "11111111";
                   end case;
       sortie <= STD_LOGIC_VECTOR(compteur);
       AN <= anode;
  end process asynchrone;
  
end Behavorial;
