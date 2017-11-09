library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity mux8_tb is
end;

architecture bench of mux8_tb is

  component mux8
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
  end component;

  signal COMMANDE: STD_LOGIC_VECTOR(2 downto 0);
  signal E0: STD_LOGIC_VECTOR(6 downto 0);
  signal E1: STD_LOGIC_VECTOR(6 downto 0);
  signal E2: STD_LOGIC_VECTOR(6 downto 0);
  signal E3: STD_LOGIC_VECTOR(6 downto 0);
  signal E4: STD_LOGIC_VECTOR(6 downto 0);
  signal E5: STD_LOGIC_VECTOR(6 downto 0);
  signal E6: STD_LOGIC_VECTOR(6 downto 0);
  signal E7: STD_LOGIC_VECTOR(6 downto 0);
  signal S0: STD_LOGIC_VECTOR(6 downto 0);
  signal DP: STD_LOGIC ;

begin

  uut: mux8 port map ( COMMANDE => COMMANDE,
                       E0       => E0,
                       E1       => E1,
                       E2       => E2,
                       E3       => E3,
                       E4       => E4,
                       E5       => E5,
                       E6       => E6,
                       E7       => E7,
                       S0       => S0,
                       DP       => DP );

  stimulus: process
  begin
  
    E0 <= "1000000";
    E1 <= "0100000";
    E2 <= "0010000";
    E3 <= "0001000";
    E4 <= "0000100";
    E5 <= "0000010";
    E6 <= "0000001";
    E7 <= "0101010";
    COMMANDE <= "000";
    
    wait for 10ns;
    COMMANDE <= "001";
    
    wait for 10ns;
    COMMANDE <= "010";
    
    wait for 10ns;
    COMMANDE <= "011";
    
    wait for 10ns;
    COMMANDE <= "100";
    
    wait for 10ns;
    COMMANDE <= "101";
    
    wait for 10ns;
    COMMANDE <= "110";
    
    wait for 10ns;
    COMMANDE <= "111";    
  end process;


end;