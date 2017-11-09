LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE IEEE.math_real.ALL;

PACKAGE audio_rom IS
	CONSTANT ROM_FREQ      : integer := 44100;
	CONSTANT ROM_MAX_ADDR  : integer := 44100;
	CONSTANT ROM_MAX_DATA  : integer :=  2048;
	CONSTANT ROM_ADDR_BITS : integer :=    16;
	CONSTANT ROM_DATA_BITS : integer :=    11;
END;

-------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE work.audio_rom.ALL;

ENTITY wav_rom IS
PORT (
      CLOCK     : IN  STD_LOGIC;
      WRITE_EN  : IN  STD_LOGIC;
      DATA_IN   : IN  STD_LOGIC_VECTOR(15 DOWNTO 0);
      ADDR      : IN  STD_LOGIC_VECTOR(ROM_ADDR_BITS-1 DOWNTO 0);
      ADDR_IN   : IN  STD_LOGIC_VECTOR(15 DOWNTO 0);
      DATA_OUT  : OUT STD_LOGIC_VECTOR(ROM_DATA_BITS-1 DOWNTO 0)
      );
END wav_rom;

ARCHITECTURE Behavioral OF wav_rom IS
 
  TYPE     rom_type IS ARRAY (0 TO (ROM_MAX_ADDR-1)) OF SIGNED (ROM_DATA_BITS-1 DOWNTO 0);
  signal memory : rom_type;
 
BEGIN

  PROCESS (CLOCK)
  BEGIN
    IF (CLOCK'event AND CLOCK = '1') THEN
        if WRITE_EN = '1' then
            memory(to_integer(UNSIGNED(ADDR_IN))) <= SIGNED(DATA_IN);
        else 
            DATA_OUT <= STD_LOGIC_VECTOR( memory(to_integer(UNSIGNED(ADDR))) );
        end if;
    END IF;
  END PROCESS;

END Behavioral;