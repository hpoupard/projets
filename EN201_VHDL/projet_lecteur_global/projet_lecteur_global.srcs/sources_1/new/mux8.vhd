library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity mux8 is
  port (
    COMMANDE : in STD_LOGIC_VECTOR(2 downto 0);
    E0 : in STD_LOGIC_VECTOR(6 downto 0);
    E1 : in STD_LOGIC_VECTOR(6 downto 0);
    E2 : in STD_LOGIC_VECTOR(6 downto 0);
    E3 : in STD_LOGIC_VECTOR(6 downto 0);
    E4 : in STD_LOGIC_VECTOR(6 downto 0);
    E5 : in STD_LOGIC_VECTOR(6 downto 0);
    E6 : in STD_LOGIC_VECTOR(6 downto 0);
    E7 : in STD_LOGIC_VECTOR(6 downto 0);
    S0 : out STD_LOGIC_VECTOR(6 downto 0);
    DP : out STD_LOGIC
  );
end mux8;

architecture Behavorial of mux8 is
begin

    process (COMMANDE, E0, E1, E2, E3, E4, E5, E6, E7)
    begin
      case COMMANDE is
        when "000" => S0 <= E0;
                      DP <= '0';
        when "001" => S0 <= E1;
                      DP <= '1';
        when "010" => S0 <= E2;
                      DP <= '1';
        when "011" => S0 <= E3;
                      DP <= '1';
        when "100" => S0 <= E4;
                      DP <= '1';
        when "101" => S0 <= E5;
                      DP <= '1';
        when "110" => S0 <= E6;
                      DP <= '1';
        when "111" => S0 <= E7;
                      DP <= '1';
        when others => S0 <= "0000000";
                       DP <= '1';
      end case;
  end process;
end Behavorial;
