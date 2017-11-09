library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity detect_impulsion is
  port (
    CLOCK : in STD_LOGIC;
    INPUT : in STD_LOGIC;
    OUTPUT : out STD_LOGIC
    );
  end detect_impulsion;

architecture Behavorial of detect_impulsion is

  signal memoire : STD_LOGIC := '0';
  
  begin
    
    process(CLOCK)
    begin
      if rising_edge(CLOCK) then
        memoire <= INPUT;
      end if;
    end process;

    OUTPUT <= ((INPUT) xor (memoire)) and (INPUT);
    
  end Behavorial;
