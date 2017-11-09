library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity cmp_addr is
  Port ( CLOCK : in STD_LOGIC;
         CE : in STD_LOGIC;
         ADDR_IN : in STD_LOGIC_VECTOR (15 downto 0);
         RESET : in STD_LOGIC;
         ADDR : out STD_LOGIC_VECTOR (15 downto 0)
       );
end cmp_addr;

architecture Behavioral of cmp_addr is

  signal compteur_44100 : integer range 0 to 4099;

begin

  processus_synchrone : process (CLOCK)
  variable compteur_max : unsigned := UNSIGNED(ADDR_IN);
  begin
    if (falling_edge(CLOCK)) then
      if RESET = '1' then
        compteur_44100 <= 0;
      elsif compteur_44100 = 4099 then
        compteur_44100 <= 0;
      elsif compteur_44100 = compteur_max then
        compteur_44100 <= 0;
      elsif CE = '1' then
        compteur_44100 <= compteur_44100 + 1;
      end if;
    end if;
  end process processus_synchrone;

  ADDR <= STD_LOGIC_VECTOR(TO_UNSIGNED(compteur_44100, 16));
  
end Behavioral;
