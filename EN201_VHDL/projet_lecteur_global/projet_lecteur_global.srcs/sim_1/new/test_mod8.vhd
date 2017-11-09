library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity test_mod8 is
end entity test_mod8;

architecture workbench_mod8 of test_mod8 is

  signal CLOCK : STD_LOGIC;
  signal RESET : STD_LOGIC;
  signal C_PERC : STD_LOGIC;
  signal AN : STD_LOGIC_VECTOR(7 downto 0);
  signal sortie : STD_LOGIC_VECTOR(2 downto 0);

  signal periode_c : time := 10ns;
  signal periode_p : time := 100ns ;
  component mod8 is
      port (
        CLOCK : in STD_LOGIC;
        RESET : in STD_LOGIC;
        C_PERC : in STD_LOGIC;
        AN : out STD_LOGIC_VECTOR(7 downto 0);
        sortie : out STD_LOGIC_VECTOR(2 downto 0)
      );
  end component mod8;

begin

  instance_mod8 : mod8
    port map (
      CLOCK => CLOCK,
      RESET => RESET,
      C_PERC => C_PERC,
      AN => AN,
      sortie => sortie);

  clock_c : process
  begin
    CLOCK <= '1';
    wait for periode_c/2;
    CLOCK <= '0';
    wait for periode_c/2;
  end process clock_c;

  clock_p : process
  begin
    C_PERC <= '1';
    wait for periode_c;
    C_PERC <= '0';
    wait for periode_p;
  end process clock_p;
  
  stimuli : process
  begin
      RESET <= '1';
      wait for periode_c*2;
      
      RESET <= '0';
      wait for 1ms;
  end process stimuli;
  
end workbench_mod8;
